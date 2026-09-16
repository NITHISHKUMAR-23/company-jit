SUMMARY = "Dual Camera Live Preview"
DESCRIPTION = "SDL2-based dual camera preview app for Raspberry Pi (OV5642 SPI + OV5647 CSI)"
LICENSE = "CLOSED"

SRC_URI = "file://SPI_OV5647_Live_Preview/"

S = "${WORKDIR}/SPI_OV5647_Live_Preview"

# Dependencies
DEPENDS += "libsdl2 libjpeg-turbo pkgconfig"

do_compile() {
    # Correct shell variable syntax (no spaces around =)
    CFLAGS_SDL2="-I${STAGING_INCDIR}/SDL2"
    LDFLAGS_SDL2="-L${STAGING_LIBDIR} -lSDL2"

    # Call make with combined flags
    make \
        CFLAGS="${CFLAGS} ${CFLAGS_SDL2}" \
        LDFLAGS="${LDFLAGS} ${LDFLAGS_SDL2} -ljpeg -lpthread"
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/ArducamSDL_Live_combined ${D}${bindir}/ArducamSDL_Live_combined
}

FILES:${PN} += "${bindir}/ArducamSDL_Live_combined"
