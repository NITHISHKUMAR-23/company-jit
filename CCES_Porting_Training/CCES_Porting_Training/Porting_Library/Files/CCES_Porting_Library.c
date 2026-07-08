/*****************************************************************************
 * CCES_Porting_Library.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "CCES_Porting_Library.h"

#include <sys/platform.h>
//#include "Lib_segment.h"
//#pragma default_section(CODE,SEG_LIBRARY_CODE)
//#pragma default_section(ALLDATA,SEG_LIBRARY_DATA)

float calculateRMS(float* data, uint16_t length) {
    float sum = 0.0;
    for (uint16_t i = 0; i < length; i++) {
        sum += data[i] * data[i];
    }
    return sqrt(sum / length);
}

// Function definition to calculate mean
float calculateMean(float* data, uint16_t length) {
    float sum = 0.0;
    for (uint16_t i = 0; i < length; i++) {
        sum += data[i];
    }
    return sum / length;
}

// Function definition to calculate variance
float calculateVariance(float* data, uint16_t length) {
    float mean = calculateMean(data, length);
    float sum = 0.0;
    for (uint16_t i = 0; i < length; i++) {
        sum += (data[i] - mean) * (data[i] - mean);
    }
    return sum / length;
}

// Function definition to calculate standard deviation
float calculateStandardDeviation(float* data, uint16_t length) {
    return sqrt(calculateVariance(data, length));
}

