/*****************************************************************************
 * CCES_Porting_Kernel.h
 *****************************************************************************/

#ifndef __CCES_PORTING_KERNEL_H__
#define __CCES_PORTING_KERNEL_H__

#include <stdio.h>
#include <stdlib.h>
/* Add your custom header content here */
float calculateRMS(float* data, uint16_t length);
float calculateMean(float* data, uint16_t length);
float calculateVariance(float* data, uint16_t length);
float calculateStandardDeviation(float* data, uint16_t length);

#endif /* __CCES_PORTING_KERNEL_H__ */
