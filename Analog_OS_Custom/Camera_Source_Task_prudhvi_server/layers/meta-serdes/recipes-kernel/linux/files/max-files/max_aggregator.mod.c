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
	{ 0x86f905dc, "__platform_driver_register" },
	{ 0x4f2be95c, "v4l2_async_unregister_subdev" },
	{ 0x30cf62a7, "platform_driver_unregister" },
	{ 0x8dd6b0c4, "devm_kmalloc" },
	{ 0xae072380, "of_property_read_variable_u32_array" },
	{ 0x6bb4415, "v4l2_subdev_init" },
	{ 0x5792f848, "strlcpy" },
	{ 0xa88d5126, "media_entity_pads_init" },
	{ 0x2f54373, "v4l2_async_register_subdev" },
	{ 0xba34f787, "_dev_err" },
	{ 0x88cdfae9, "module_layout" },
};

MODULE_INFO(depends, "v4l2-async,videodev,mc");

MODULE_ALIAS("of:N*T*Cmaxim,aggregator");
MODULE_ALIAS("of:N*T*Cmaxim,aggregatorC*");

MODULE_INFO(srcversion, "277B8B2BC2D7519C4F4A218");
