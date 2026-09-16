// ArducamSDL_Live_combined.c - OV5642 SPI + OV5647 libcamera -> single SDL window
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <jpeglib.h>
#include <stdint.h>
#include <signal.h>
#include <SDL2/SDL.h>
#include <pthread.h>
#include <string.h>

#include "ArduCAM.h"
#include "sccb_bus.h"

extern char readbuf[JPEG_BUF_SIZE];
volatile int run = 1;

unsigned char *ov5647_rgb = NULL;
int ov5647_w = 0, ov5647_h = 0;
pthread_mutex_t ov5647_lock = PTHREAD_MUTEX_INITIALIZER;

void sigint_handler(int sig) { run = 0; }

// ---------- JPEG -> RGB24 ----------
unsigned char *jpeg_to_rgb24(unsigned char *jpegBuf, unsigned int jpegSize, int *out_w, int *out_h) {
    struct jpeg_decompress_struct cinfo;
    struct jpeg_error_mgr jerr;
    JSAMPARRAY buffer;
    unsigned char *rgb = NULL;
    int row_stride;

    cinfo.err = jpeg_std_error(&jerr);
    jpeg_create_decompress(&cinfo);
    jpeg_mem_src(&cinfo, jpegBuf, jpegSize);
    if (jpeg_read_header(&cinfo, TRUE) != JPEG_HEADER_OK) {
        jpeg_destroy_decompress(&cinfo);
        return NULL;
    }
    jpeg_start_decompress(&cinfo);

    *out_w = cinfo.output_width;
    *out_h = cinfo.output_height;
    row_stride = cinfo.output_width * cinfo.output_components;
    rgb = malloc(cinfo.output_width * cinfo.output_height * 3);
    if (!rgb) {
        jpeg_finish_decompress(&cinfo);
        jpeg_destroy_decompress(&cinfo);
        return NULL;
    }

    buffer = (*cinfo.mem->alloc_sarray)((j_common_ptr)&cinfo, JPOOL_IMAGE, row_stride, 1);
    unsigned char *p = rgb;
    while (cinfo.output_scanline < cinfo.output_height) {
        jpeg_read_scanlines(&cinfo, buffer, 1);
        memcpy(p, buffer[0], row_stride);
        p += row_stride;
    }
    jpeg_finish_decompress(&cinfo);
    jpeg_destroy_decompress(&cinfo);
    return rgb;
}

// ---------- OV5647 libcamera thread ----------
void *ov5647_thread(void *arg) {
    const char *cmd = "libcamera-vid -t 0 --inline --codec mjpeg --width 640 --height 480 -o -";
    FILE *pipe = popen(cmd, "r");
    if (!pipe) {
        fprintf(stderr, "Failed to start libcamera-vid!\n");
        run = 0;
        return NULL;
    }

    unsigned char buffer[4096];
    unsigned char temp[1024*1024];
    size_t temp_len = 0;

    while (run) {
        size_t n = fread(buffer, 1, sizeof(buffer), pipe);
        if (n == 0) break;

        if (temp_len + n < sizeof(temp)) {
            memcpy(temp + temp_len, buffer, n);
            temp_len += n;
        } else {
            temp_len = 0; // discard overflow
        }

        // look for JPEG SOI/EOI
        unsigned char *start = memmem(temp, temp_len, "\xFF\xD8", 2);
        unsigned char *end   = memmem(temp, temp_len, "\xFF\xD9", 2);
        if (start && end && end > start) {
            size_t jpg_len = end - start + 2;
            unsigned char *jpg_buf = malloc(jpg_len);
            memcpy(jpg_buf, start, jpg_len);

            unsigned char *decoded = jpeg_to_rgb24(jpg_buf, jpg_len, &ov5647_w, &ov5647_h);
            free(jpg_buf);

            if (decoded) {
                pthread_mutex_lock(&ov5647_lock);
                if (ov5647_rgb) free(ov5647_rgb);
                ov5647_rgb = decoded;
                pthread_mutex_unlock(&ov5647_lock);
            }

            // remove processed bytes
            size_t remaining = temp_len - (end - temp + 2);
            memmove(temp, end + 2, remaining);
            temp_len = remaining;
        }
    }

    pclose(pipe);
    return NULL;
}

int main() {
    signal(SIGINT, sigint_handler);
    length = 0;

    // ---------------- OV5642 SPI init ----------------
    pioInit();
    ArduCAM_CS_init(CAM_CS1, -1, -1, -1);
    sccb_bus_init();
    spiInit(4000000, 0);
    Arducam_bus_detect(CAM_CS1, -1, -1, -1);
    resetFirmware(CAM_CS1, -1, -1, -1);
    ArduCAM_Init(OV5642);

    // ---------------- SDL init ----------------
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        fprintf(stderr, "SDL_Init failed: %s\n", SDL_GetError());
        return 1;
    }

    SDL_Window *win = SDL_CreateWindow("Dual Camera Live Preview",
                                       SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
                                       1280, 480, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);
    SDL_Renderer *ren = SDL_CreateRenderer(win, -1, SDL_RENDERER_ACCELERATED);
    SDL_Texture *tex = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGB24,
                                         SDL_TEXTUREACCESS_STREAMING, 1280, 480);

    // ---------------- start OV5647 thread ----------------
    pthread_t tid;
    pthread_create(&tid, NULL, ov5647_thread, NULL);

    printf("Starting dual live preview... press Ctrl+C to exit.\n");

    while (run) {
        SDL_Event e;
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) run = 0;
        }

        // -------- OV5642 capture ----------
        singleCapture(CAM_CS1);
        int cam_w = 0, cam_h = 0;
        unsigned char *decoded = jpeg_to_rgb24((unsigned char *)readbuf, (unsigned int)length, &cam_w, &cam_h);
        if (!decoded) continue;

        // -------- merge OV5642 + OV5647 ----------
        unsigned char *combined = malloc(1280 * 480 * 3);
        if (combined) {
            // copy OV5642 left
            for (int y=0; y<cam_h; y++) {
                memcpy(combined + y*1280*3, decoded + y*cam_w*3, cam_w*3);
            }

            // copy OV5647 right
            pthread_mutex_lock(&ov5647_lock);
            if (ov5647_rgb) {
                for (int y=0; y<ov5647_h; y++) {
                    memcpy(combined + y*1280*3 + 640*3, ov5647_rgb + y*640*3, 640*3);
                }
            }
            pthread_mutex_unlock(&ov5647_lock);

            SDL_UpdateTexture(tex, NULL, combined, 1280*3);
            free(combined);
        }

        SDL_RenderClear(ren);
        SDL_RenderCopy(ren, tex, NULL, NULL);
        SDL_RenderPresent(ren);

        free(decoded);
        usleep(30000);
    }

    pthread_join(tid, NULL);
    if (ov5647_rgb) free(ov5647_rgb);

    SDL_DestroyTexture(tex);
    SDL_DestroyRenderer(ren);
    SDL_DestroyWindow(win);
    SDL_Quit();
    return 0;
}
