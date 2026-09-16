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
	.arch = MODULE_ARCH_INIT,
};

MODULE_INFO(intree, "Y");

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

SYMBOL_CRC(max_ser_i2c_regmap, 0xedef2e45, "_gpl");
SYMBOL_CRC(max_ser_probe, 0xf2cd893f, "_gpl");
SYMBOL_CRC(max_ser_remove, 0x6c6eed0e, "_gpl");
SYMBOL_CRC(max_ser_reset, 0x5e8ceda9, "_gpl");
SYMBOL_CRC(max_ser_wait_for_multiple, 0x91be4e2e, "_gpl");
SYMBOL_CRC(max_ser_wait, 0xfa1b8d8b, "_gpl");
SYMBOL_CRC(max_ser_change_address, 0xc0458301, "_gpl");
SYMBOL_CRC(max_des_i2c_regmap, 0xef1a6795, "_gpl");
SYMBOL_CRC(max_des_probe, 0x6bd8cdb4, "_gpl");
SYMBOL_CRC(max_des_remove, 0xdeb181b8, "_gpl");
SYMBOL_CRC(max_format_by_index, 0x3c1859a4, "_gpl");
SYMBOL_CRC(max_format_by_code, 0x23778b76, "_gpl");
SYMBOL_CRC(max_format_by_dt, 0x1f56c382, "_gpl");

static const struct modversion_info ____versions[]
__used __section("__versions") = {
	{ 0x7915bec3, "v4l2_i2c_subdev_init" },
	{ 0x98092eda, "device_property_present" },
	{ 0x15d57e21, "of_fwnode_ops" },
	{ 0x18cf5f50, "regmap_write" },
	{ 0x8dd6b0c4, "devm_kmalloc" },
	{ 0x656e4a6e, "snprintf" },
	{ 0x590f8169, "fwnode_graph_get_remote_endpoint" },
	{ 0x4f2be95c, "v4l2_async_unregister_subdev" },
	{ 0x4a240787, "v4l2_fwnode_endpoint_free" },
	{ 0x42ef4c56, "v4l2_i2c_subdev_set_name" },
	{ 0xa8072c15, "fwnode_get_parent" },
	{ 0xaa4f3ffb, "i2c_new_dummy_device" },
	{ 0x958e5909, "i2c_atr_delete" },
	{ 0x8da6585d, "__stack_chk_fail" },
	{ 0x10319bac, "i2c_atr_get_driver_data" },
	{ 0x4425ebc9, "fwnode_property_read_u32_array" },
	{ 0xf1f1c0d, "v4l2_subdev_link_validate" },
	{ 0xba34f787, "_dev_err" },
	{ 0xfe676259, "i2c_unregister_device" },
	{ 0xdf8b0bcb, "i2c_atr_add_adapter" },
	{ 0x4dfa8d4b, "mutex_lock" },
	{ 0xa88d5126, "media_entity_pads_init" },
	{ 0x91bf6962, "__regmap_init_i2c" },
	{ 0xcefb0c9f, "__mutex_init" },
	{ 0xdcb764ad, "memset" },
	{ 0x180d9fab, "fwnode_property_present" },
	{ 0x12644a62, "regmap_read" },
	{ 0x3213f038, "mutex_unlock" },
	{ 0x2c23f3ca, "fwnode_graph_get_endpoint_by_id" },
	{ 0x685ae51a, "v4l2_fwnode_endpoint_alloc_parse" },
	{ 0x2ffc399f, "regmap_update_bits_base" },
	{ 0x1df7003e, "of_node_name_eq" },
	{ 0x8bd94112, "i2c_atr_new" },
	{ 0xe73c9010, "regmap_exit" },
	{ 0x4a81a361, "fwnode_handle_put" },
	{ 0x998e9023, "device_get_next_child_node" },
	{ 0xdf73ff88, "v4l2_fwnode_endpoint_parse" },
	{ 0x63109546, "i2c_atr_set_driver_data" },
	{ 0x359743d7, "fwnode_graph_get_remote_port_parent" },
	{ 0xf9a482f9, "msleep" },
	{ 0x2f54373, "v4l2_async_register_subdev" },
	{ 0x86c4742b, "i2c_atr_del_adapter" },
	{ 0x88cdfae9, "module_layout" },
};

MODULE_INFO(depends, "videodev,v4l2-async,v4l2-fwnode,mc,regmap-i2c");


MODULE_INFO(srcversion, "F1A3BFE23B9217B4A8047BE");
