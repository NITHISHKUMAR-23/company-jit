# Prepend the files directory to FILESEXTRAPATHS using modern syntax
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Append install steps using modern override syntax
do_install:append() {
    install -d ${D}${sysconfdir}/boot/
    install -m 0644 ${THISDIR}/files/config.txt ${D}${sysconfdir}/boot/
}
