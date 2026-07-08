    1.  Description

        This example demonstrates how to build the initialization code for ADSP-2156x family of SHARC processors.

        Refer to the source code embedded Doxygen documentation comments in the 2156x_InitPreload_code.c for further details.

        There are 4 project covered by this common readme.

          2156x_init    - Inititialization code project for ADSP-2156x to be used as the basis for custom hardware support.
          2156x_preload - CCES preload code project to be used as the basis for custom hardware support.

          21569_init    - Inititialization code project for the ADSP-21569 EZ-KIT.
          21569_preload - CCES preload code project for the ADSP-21569 EZ-KIT.

        The Default frequency settings for the ADSP-21569 EZ-KIT support are as follows:

        CGU0:--
          PLL                     :   2000 MHz
          CCLK                    :   1000.0 MHz
          SYSCLK                  :   500.0  MHz
          SCLK0                   :   125.0 MHz
          SCLK1(SPDIF RX)         :   333.33 MHz  //CHANGE: 250 to 333.33 MHz
          DCLK                    :   666.667 MHz
          OCLK (LP CLOCK)         :   125.0 MHz

        CGU1:--
          PLL                     :   1600 MHz
          DCLK0_1                 :   533 MHz (DDR Clock is sourced from CGU1)

        CDU:--
          SPI(0-2) CLOCK SOURCE (CLKO0)  :   SCLK0_0      :   125 MHz
          DDR CLOCK             (CLKO1)  :   DCLK0_1      :   533 MHz

        These ADSP-21569 EZ-KIT settings are configured using MACROs defined as follows in the config.h include file:-

        /*Common macros*/
        #define CLKIN   (25000000)               /*!< SYS_CLKIN value*/
        #define CONFIG_DMC0 (ISSI_8Gb_DDR3_533MHZ)/*!< Define as 0, if there is no DDR on the board or the chip*/
        #define CONFIG_SPIFLASH (1)              /*!< Define as 0, if there is no SPI Flash on the board or the chip*/
        #define EXECUTE_SAFE_STATE (1)           /*!< Define as 1, if the program must go in to a safe state up on errors in the API calls*/

        /*Boot related macros*/
        #define CONFIG_BOOT_UART_BAUD_RATE (0)   /*!< Define as 1, if the UART Baud Rate need to be recalculated and reinitialized*/
        #define CONFIG_BOOT_SPI_CLOCK_RATE (0)   /*!< Define as 1, if the SPI Clock Rate need to be recalculated and reinitialized*/
        #define CONFIG_BOOT_OSPI_CLOCK_RATE (0)  /*!< Define as 1, if the OSPI Clock Rate need to be recalculated and reinitialized*/
        #define DO_PROCESS_BOOTSTRUCT (0)        /*!< Define as 1, if there is need to process the boot struct passed by ROM*/

        For the 2156x_init and 2156x_preload projects there are no defined provided in config.h and instead there is
        a preprocessor #error statement as a reminder that configuration for custom hardware is required when using
        these projects.

    2.  Processors

        ADSP-21569

    3.  Hardware Setup

        NULL

    4.  References

        ADSP-21569 Hardware Reference Manual
        ADSP-21569 EZ-Board Schematic

