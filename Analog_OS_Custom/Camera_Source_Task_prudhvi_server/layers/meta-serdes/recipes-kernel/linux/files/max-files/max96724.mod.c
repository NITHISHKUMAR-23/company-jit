#include <linux/module.h>
#define INCLUDE_VERMAGIC
#include <linux/build-salt.h>
#include <linux/elfnote-lto.h>
#include <linux/export-internal.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;
BUILD_LTO_INFO;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

MODULE_INFO(intree, "Y");

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif


static const struct modversion_info ____versions[]
__used __section("__versions") = {
	{ 0xbf804d63, "i2c_register_driver" },
	{ 0x2ffc399f, "regmap_update_bits_base" },
	{ 0x4c5541a, "__dynamic_dev_dbg" },
	{ 0xba34f787, "_dev_err" },
	{ 0x18cf5f50, "regmap_write" },
	{ 0xdeb181b8, "max_des_remove" },
	{ 0x2a395d3d, "i2c_del_driver" },
	{ 0x12644a62, "regmap_read" },
	{ 0xf9a482f9, "msleep" },
	{ 0x8da6585d, "__stack_chk_fail" },
	{ 0x8dd6b0c4, "devm_kmalloc" },
	{ 0xef1a6795, "max_des_i2c_regmap" },
	{ 0xea5d8f4f, "__devm_regmap_init_i2c" },
	{ 0x6bd8cdb4, "max_des_probe" },
	{ 0x88cdfae9, "module_layout" },
};

MODULE_INFO(depends, "max_serdes_all,regmap-i2c");

MODULE_ALIAS("of:N*T*Cmaxim,max96724");
MODULE_ALIAS("of:N*T*Cmaxim,max96724C*");

MODULE_INFO(srcversion, "9A7204825CF0AA11A7ABC90");
