/*
 * SPI.h
 *
 *  Created on: Dec 23, 2020
 *      Author: kkowticw
 */

#ifndef SPI_COMMON_H_
#define SPI_COMMON_H_

/* SPI Buffer for submission of DMA Descriptor */
typedef struct adi_spi_buffer    {
    void                        *pData;                             // pointer to data
    unsigned long               ElementCount;                       // data element count
} ADI_SPI_BUFFER;


#endif /* SPI_COMMON_H_ */
