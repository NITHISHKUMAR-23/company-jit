/*****************************************************************************
 * CCES_Porting_Library.h
 *****************************************************************************/

#ifndef __CCES_PORTING_LIBRARY_H__
#define __CCES_PORTING_LIBRARY_H__

#include <math.h>
#include <stdint.h>

// Function declarations for embedded-related calculations

float calculateRMS(float* data, uint16_t length);
float calculateMean(float* data, uint16_t length);
float calculateVariance(float* data, uint16_t length);
float calculateStandardDeviation(float* data, uint16_t length);

#endif /* __CCES_PORTING_LIBRARY_H__ */
