#include "dapctl.h"

#include <asio.hpp>
#include <iostream>
#include <sstream>
#include <string>
#include <iomanip>
using asio::ip::tcp;
using namespace std;


//g++ -std=c++17 -fPIC -shared main.cpp -o libconsole.so

static void basic_log(const char* function, const std::string message)
{
    std::cerr << "[dapctl_tcp:" << function << "] " << message << "\n";
}

#define LOG(LOGMSG) basic_log(__FUNCTION__, LOGMSG)
#define GetRtCoreVersion_command_ID				   (0x15)
#define HEADER_H ((uint8_t)0xAA) 
#define HEADER_L ((uint8_t)0x55)
#define FOOTER_H ((uint8_t)0x55)
#define FOOTER_L ((uint8_t)0xAA)
#define UART_BUFF_SIZE  1033


static uint8_t temp_flag = 1;
uint8_t CRC8 = 0;

uint8_t CRC_calculation(const unsigned char* data, int length);

struct dapctl {
    dapctl(std::string port, std::string baud_rate)
        : m_port(port)
        , m_baud_rate(baud_rate)
        , m_serial_port(m_io_context)
    {
    }

    bool write_msg(const void* data, int32_t size)
    {
        asio::error_code error;
        // Send payload
        asio::write(m_serial_port, asio::buffer(data, size), error);
        if (error) {
            m_connected = false;
            return false;
        }

        return true;
    }

    bool read_msg(void* data, int32_t* size) {
        asio::error_code error;
        int32_t payload_size = 0;

        uint8_t HEADER[] = { HEADER_H, HEADER_L };
        const int TARGET_SIZE = UART_BUFF_SIZE;
        const int PAYLOAD_LEN_START = sizeof(HEADER);
        const int PAYLOAD_START = sizeof(HEADER) + sizeof(int32_t);
        const int CRC_POSITION = 6 + DAPCTL_MAX_MESSAGE_SIZE;     // CRC is always at byte 1030
        const int FOOTER_POSITION = 1031;  // Footer starts immediately after CRC

        while (true) {
            // Continuously attempt to read until successful

            // Wait for incoming data on the serial port
            asio::read(m_serial_port, asio::buffer(data, *size), error);

            if (error) {
                if (error == asio::error::would_block) {
                    printf("error case\n");
                    // Keep retrying as no data is available yet
                    continue;
                }
                else {
                    // On other errors, mark as disconnected and return false
                    m_connected = false;
                    std::cerr << "Error: " << error.message() << std::endl;
                    return false;
                }
            }
            else {
                // Successfully received data
                uint8_t* buffer = static_cast<uint8_t*>(data);
                /*
                printf("Received Data (%d bytes):\n", *size);
                for (size_t i = 0; i < *size; ++i) {
                    printf("0x%02X ", buffer[i]);
                }
				*/
                int32_t payload_size = (buffer[2]) |
                    (buffer[3] << 8) |
                    (buffer[4] << 16) |
                    (buffer[5] << 24);

                if (buffer[0] != HEADER_H || buffer[1] != HEADER_L || buffer[1031] != FOOTER_H || buffer[1032] != FOOTER_L) {
                    LOG("\nHEADER \\ FOOTER is invalid...\n");
                }

                else {
                    *size = payload_size;
                    int32_t payload_end = PAYLOAD_START + DAPCTL_MAX_MESSAGE_SIZE;
                    int32_t crc_start = payload_end;  // CRC starts immediately after payload
                    int32_t crc_end = crc_start + 1;  // CRC size (assuming 1 byte)

                    // Compute expected CRC
                    uint8_t calculated_crc = CRC_calculation(&buffer[2], 4 + DAPCTL_MAX_MESSAGE_SIZE);

                    // Extract received CRC
                    uint8_t received_crc = buffer[CRC_POSITION];

                    // CRC validation
                    if (received_crc != calculated_crc) {
                        printf("CRC Mismatch! Received: 0x%02X, Expected: 0x%02X\n", received_crc, calculated_crc);
                        return false; // Discard message due to CRC failure
                    }

                    for (int i = PAYLOAD_START; i < payload_end; i++)
                    {
                        buffer[i - PAYLOAD_START] = buffer[i];
                    }
                    return true;
                }
            }
        }
    }
    bool connected() { return m_connected; }

    bool connect()
    {
        try {
            m_serial_port.open(m_port);
            m_serial_port.set_option(asio::serial_port_base::baud_rate(std::stoi(m_baud_rate)));
            LOG("Connected to DAP");
            m_connected = true;
            return true;
        }
        catch (const std::exception& e) {
            LOG(e.what());
            return false;
        }
    }

private:
    std::string m_port;
    std::string m_baud_rate;

    bool m_connected = false;

    asio::io_context m_io_context;
    asio::serial_port m_serial_port;
};

dapctl_status dapctl_open(dapctl** ptr, const char* uri)
{
    LOG(uri);

    std::string ip;
    std::string port;

    std::istringstream f(uri);
    if (!std::getline(f, ip, ':')) {
        LOG("Failed to get ip");
        return DAPCTL_STATUS_FAILED;
    }

    f >> port;

    if (port == "") {
        LOG("Failed to get port");
        return DAPCTL_STATUS_FAILED;
    }

    auto* me = new dapctl(ip, port);

    // try to make a first connection
    me->connect();

    *ptr = me;

    return DAPCTL_STATUS_SUCCESS;
}

dapctl_status dapctl_close(dapctl* handle)
{
    delete handle;
    return DAPCTL_STATUS_SUCCESS;
}


dapctl_status dapctl_dispatch_message(dapctl* handle, void* payload, int32_t* size)
{
    uint8_t HEADER[] = { HEADER_H, HEADER_L };
    const int TARGET_SIZE = UART_BUFF_SIZE;

    const int PAYLOAD_LEN_START = sizeof(HEADER);
    const int PAYLOAD_START = sizeof(HEADER) + sizeof(int32_t);
    uint8_t temp_payload[TARGET_SIZE] = { 0 };

    // Pack the header and payload length
    memcpy(temp_payload, HEADER, sizeof(HEADER));  // 2 bytes for HEADER
    memcpy(&temp_payload[PAYLOAD_LEN_START], size, sizeof(int32_t));
    memcpy(&temp_payload[PAYLOAD_START], payload, *size);  // Copy actual payload data

    // Padding after the payload
    int padding_start = PAYLOAD_START + *size;
    int padding_end = TARGET_SIZE - sizeof(uint8_t) * 3;
    for (int j = padding_start; j < padding_end; j++) {
        temp_payload[j] = 0; // Padding bytes
    }

    // Calculate and append CRC
    CRC8 = CRC_calculation(&temp_payload[2], (TARGET_SIZE - 5));
    uint8_t FOOTER[] = { CRC8, HEADER_L, HEADER_H };
    memcpy(&temp_payload[TARGET_SIZE - 3], FOOTER, sizeof(FOOTER));  // 3 bytes for FOOTER

    printf("initial data (%d bytes):", *size);
    for (int i = 0; i < ((*size) + 6); i++) {
        printf("   %d ", temp_payload[i]);
    }
    printf("\n");
    *size = TARGET_SIZE;  // Set size to the target size (with header + payload + footer)
    // Send the message to the hardware
    if (!handle->write_msg(temp_payload, *size)) {
        LOG("Failed to send message to the hardware");
        return DAPCTL_STATUS_FAILED;
    }

    // Wait for the response from the hardware (maximum 39 bytes)
    if (!handle->read_msg(temp_payload, size)) {
        LOG("Failed to read response from hardware or timeout occurred");
        return DAPCTL_STATUS_FAILED;
    }
    memcpy(payload, temp_payload, *size);
    // Print the received data for debugging
   /*printf("Received Response (%d bytes):", *size);
    for (int i = 0; i < *size; i++) {
        printf("%d ", temp_payload[i]);
    }
    printf("\n");*/
    return DAPCTL_STATUS_SUCCESS;
}


uint8_t CRC_calculation(const unsigned char* data, int length) {
    uint8_t curr_crc = 0xAA;
    uint8_t sum1 = (uint8_t)curr_crc;
    uint8_t sum2 = (uint8_t)(curr_crc >> 8);
    int index;
    for (index = 0; index < length; index++)
    {
        sum1 = (sum1 + data[index]) % 255;
        sum2 = (sum2 + sum1) % 255;
    }
    return (uint8_t)((sum2 << 8) | sum1);  // Cast to uint8_t to match hardware return type
}
