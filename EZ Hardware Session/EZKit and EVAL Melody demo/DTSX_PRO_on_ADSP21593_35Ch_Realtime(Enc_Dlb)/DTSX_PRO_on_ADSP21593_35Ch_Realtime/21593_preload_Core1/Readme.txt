    1.  Description

        This example demonstrates how to build the initialization code for ADSP-2159x/SC59x family of processors.

        Refer to the source code embedded Doxygen documentation comments in the SC59x_InitPreload_code.c for further details.

        There are 8 projects covered by this common readme: 
          2159x_init    - Inititialization code project for ADSP-2159x to be used as the basis for custom hardware support.
          2159x_preload - CCES preload code project to be used as the basis for custom hardware support.
          SC59x_init    - Inititialization code project for ADSP-SC59x to be used as the basis for custom hardware support.
          SC59x_preload - CCES preload code project to be used as the basis for custom hardware support.

          21593_init    - Inititialization code project for the EV-21593-SOM Board.
          21593_preload - CCES preload code project for the EV-21593-SOM Board.
          SC594W_init    - Inititialization code project for the EV-SC594-SOM Board.
          SC594W_preload - CCES preload code project for the EV-SC594-SOM Board.

        The Default frequency settings for the SOM Board support are as follows:

        CGU0:--
          PLL                     :   2000.0 MHz
          CCLK                    :   1000.0 MHz
          SYSCLK                  :   500.0  MHz
          SCLK0                   :   125.0 MHz
          SCLK1                   :   250.0 MHz
          SCLK1_EXEN              :   333.33 MHz
          DCLK                    :   1000.0 MHz
          OCLK                    :   250.0 MHz
          Use S1SELEX?            :   Yes

        CGU1:--
          PLL                     :   1600.0 MHz
          CCLK                    :   800.0 MHz
          SYSCLK                  :   400.0 MHz
          SCLK0                   :   100.0 MHz
          SCLK1                   :   200.0 MHz
          SCLK1_EXEN              :   100.0 MHz
          DCLK                    :   800.0 MHz
          OCLK (LP CLOCK)         :   100.0 MHz
          Use S1SELEX?            :   No

		CDU Initialization Options
		--------------------------
		SHARC0 & its Accelerators  (CLKO0) : CCLK0_0      : 1000 MHz
		SHARC1 & its Accelerators  (CLKO1) : CCLK0_0      : 1000 MHz
		ARM                        (CLKO2) : CCLK1_0      : 1000 MHz
		DDR                        (CLKO3) : DCLK_1       :  800 MHz
		CANFD                      (CLKO4) : OCLK_1       :  100 MHz
		SPDIF                      (CLKO5) : SCLK1_EXEN_0 :  333.3 MHz
		SPI                        (CLKO6) : SCLK0_0      :  125 MHz
		GigE                       (CLKO7) : SCLK0_0      :  125 MHz
		LP                         (CLKO8) : SCLK0_0      :  125 MHz
		LP_DDR                     (CLKO9) : OCLK_0       :  250 MHz
		OSPI_REFCLK                (CLKO10): SYSCLK_0     :  500 MHz
		TRACE                      (CLKO12): SCLK0_0      :  125 MHz

        The SOM Board settings are configured using MACROs defined as follows in the config.h include file:-

        /*Common macros*/
        #define CLKIN   (25000000)               /*!< SYS_CLKIN value*/
        #define CONFIG_DMC0 (ISSI_8Gb_DDR3_800MHZ)/*!< Define as 0, if there is no DDR on the board or the chip*/
        #define CONFIG_SPIFLASH (1)              /*!< Define as 0, if there is no SPI Flash on the board or the chip*/
        #define EXECUTE_SAFE_STATE (1)           /*!< Define as 1, if the program must go in to a safe state up on errors in the API calls*/
        #define INIT_CANFD (1)                   /*!< Define to 1 for parts that have CANFD*/

        /*Boot related macros*/
        #define CONFIG_BOOT_UART_BAUD_RATE (0)   /*!< Define as 1, if the UART Baud Rate need to be recalculated and reinitialized*/
        #define CONFIG_BOOT_SPI_CLOCK_RATE (0)   /*!< Define as 1, if the SPI Clock Rate need to be recalculated and reinitialized*/
        #define CONFIG_BOOT_OSPI_CLOCK_RATE (0)  /*!< Define as 1, if the OSPI Clock Rate need to be recalculated and reinitialized*/
        #define DO_PROCESS_BOOTSTRUCT (0)        /*!< Define as 1, if there is need to process the boot struct passed by ROM*/

        For SC59x_init and 2159x_preload projects there are no macro definitions provided in config.h and instead there is
        a preprocessor #error statement as a reminder that configuration for custom hardware is required when using
        these projects.

    2.  Processors

        ADSP-21593, ADSP-SC594W

    3.  References

        ADSP-SC59x/ADSP-2159x SHARC+ Processor Hardware Reference
        EV-21593-SOM Manual
        EV-SC594-SOM Manual

