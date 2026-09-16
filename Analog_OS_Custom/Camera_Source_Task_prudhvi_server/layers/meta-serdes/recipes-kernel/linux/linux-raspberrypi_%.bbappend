FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Add our driver sources + kernel config fragment
SRC_URI += " \
    file://serdes.cfg \
    file://maxim-serdes/ \
"

# Apply kernel config fragment (enables our drivers)
KERNEL_FEATURES:append = " /serdes.cfg"

# Copy driver into kernel tree before do_patch
python do_prepare_maxim_serdes() {
    import os, shutil, bb

    workdir = d.getVar('WORKDIR')
    s = d.getVar('S')

    src_dir = os.path.join(workdir, 'maxim-serdes')
    if not os.path.isdir(src_dir):
        bb.fatal("maxim-serdes source dir not found: %s" % src_dir)

    dst_dir = os.path.join(s, 'drivers/media/i2c/maxim-serdes')
    bb.utils.mkdirhier(dst_dir)

    for root, dirs, files in os.walk(src_dir):
        rel = os.path.relpath(root, src_dir)
        target_root = os.path.join(dst_dir, rel) if rel != '.' else dst_dir
        bb.utils.mkdirhier(target_root)
        for fname in files:
            shutil.copy2(os.path.join(root, fname),
                         os.path.join(target_root, fname))

    bb.note(">>> maxim-serdes driver copied into kernel tree")
}

do_patch[prefuncs] += "do_prepare_maxim_serdes"

# Patch Kconfig & Makefile after do_patch
python do_patch_maxim_serdes() {
    import os, bb

    s = d.getVar('S')
    kconfig_path = os.path.join(s, 'drivers/media/i2c/Kconfig')
    makefile_path = os.path.join(s, 'drivers/media/i2c/Makefile')

    source_line = 'source "drivers/media/i2c/maxim-serdes/Kconfig"'
    obj_line = 'obj-y += maxim-serdes/\n'

    with open(kconfig_path, 'r+') as f:
        content = f.read()
        if source_line not in content:
            f.write("\n# Added by meta-serdes\n%s\n" % source_line)
            bb.note(">>> Added maxim-serdes to Kconfig")
        else:
            bb.note(">>> Kconfig already patched")

    with open(makefile_path, 'r+') as f:
        mf = f.read()
        if 'maxim-serdes' not in mf:
            f.write("\n# Added by meta-serdes\n" + obj_line)
            bb.note(">>> Added maxim-serdes to Makefile")
        else:
            bb.note(">>> Makefile already patched")
}

do_patch[postfuncs] += "do_patch_maxim_serdes"
