SUMMARY = "Dual Camera Live Preview"
DESCRIPTION = "SDL2-based dual camera preview app for Raspberry Pi (OV5642 SPI + OV5647 CSI)"
LICENSE = "CLOSED"

SRC_URI = "file://SPI_OV5647_Live_Preview/"

S = "${WORKDIR}/SPI_OV5647_Live_Preview"

# Dependencies for build
DEPENDS += "libsdl2 libjpeg-turbo pkgconfig"

do_compile() {
    # Include and library paths from sysroot
    CFLAGS_sdl2 = "-I${STAGING_INCDIR}/SDL2"
    LDFLAGS_sdl2 = "-L${STAGING_LIBDIR} -lSDL2"

        make -f Makefile_combined \
        CFLAGS="${CFLAGS} ${CFLAGS_sdl2}" \
        LDFLAGS="${LDFLAGS} ${LDFLAGS_sdl2} -ljpeg -lpthread"
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/ArducamSDL_Live_combined ${D}${bindir}/ArducamSDL_Live_combined
}

FILES:${PN} += "${bindir}/ArducamSDL_Live_combined"
