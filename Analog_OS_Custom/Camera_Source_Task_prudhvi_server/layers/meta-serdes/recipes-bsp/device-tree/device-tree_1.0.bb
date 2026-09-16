DESCRIPTION = "Device tree overlays for GMSL cameras"
LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI = "file://gmsl-overlay.dts \
           file://gmsl-cameras.dtsi \
           file://gmsl-deserializer-channel.dtsi \
           file://gmsl-serializer.dtsi"

S = "${WORKDIR}"

inherit dtc
DEPENDS += "dtc-native"

do_compile() {
    for f in gmsl-overlay.dts; do
        ${STAGING_BINDIR_NATIVE}/dtc -O dtb -o ${B}/${f%.dts}.dtbo ${WORKDIR}/$f
    done
}

do_install() {
    install -d ${D}/boot/overlays
    install -m 0644 ${B}/*.dtbo ${D}/boot/overlays/
}
