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
	{ 0x8da6585d, "__stack_chk_fail" },
	{ 0xaa892fe6, "gpiochip_get_data" },
	{ 0x7e6fe123, "pinctrl_dev_get_drvdata" },
	{ 0x12644a62, "regmap_read" },
	{ 0x45454927, "pinconf_generic_dt_node_to_map" },
	{ 0x18cf5f50, "regmap_write" },
	{ 0x8dd6b0c4, "devm_kmalloc" },
	{ 0x50959b96, "device_get_match_data" },
	{ 0xedef2e45, "max_ser_i2c_regmap" },
	{ 0xea5d8f4f, "__devm_regmap_init_i2c" },
	{ 0xdcb764ad, "memset" },
	{ 0xf9a482f9, "msleep" },
	{ 0x544c1cd4, "devm_pinctrl_register_and_init" },
	{ 0xa481d46, "pinctrl_enable" },
	{ 0x33fdb337, "gpiochip_generic_request" },
	{ 0x67bc6af9, "gpiochip_generic_free" },
	{ 0x498392b4, "gpiochip_generic_config" },
	{ 0x870c7ae1, "devm_gpiochip_add_data_with_key" },
	{ 0xf2cd893f, "max_ser_probe" },
	{ 0x6c6eed0e, "max_ser_remove" },
	{ 0x2a395d3d, "i2c_del_driver" },
	{ 0x1f56c382, "max_format_by_dt" },
	{ 0x5c4be538, "pinconf_generic_dt_free_map" },
	{ 0x88cdfae9, "module_layout" },
};

MODULE_INFO(depends, "max_serdes_all,regmap-i2c");

MODULE_ALIAS("of:N*T*Cmaxim,max96717");
MODULE_ALIAS("of:N*T*Cmaxim,max96717C*");
MODULE_ALIAS("of:N*T*Cmaxim,max9295a");
MODULE_ALIAS("of:N*T*Cmaxim,max9295aC*");

MODULE_INFO(srcversion, "0D8E08644D84022DADE1028");
