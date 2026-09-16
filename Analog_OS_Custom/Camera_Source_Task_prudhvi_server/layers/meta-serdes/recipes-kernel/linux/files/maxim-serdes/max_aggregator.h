/* SPDX-License-Identifier: GPL-2.0 */
/*
 * MAXIM Aggregator definitions
 *
 * Copyright (C) 2022 Analog Devices
 */

#ifndef __MAX_AGGREGATOR_H__
#define __MAX_AGGREGATOR_H__

#include <linux/i2c.h>

struct max_agg {
    struct i2c_client *client;
};

#endif /* __MAX_AGGREGATOR_H__ */
