/*****************************************************************************

* SPI_Core1.c

*****************************************************************************/

#include "SPI_Core1.h"

uint8_t Buffer[ADI_SPI_BIDIR_MEMORY_SIZE];	// Buffer for SPI bidirectional communication
int8_t src_list[LIST_SIZE];					// Data list to transmit over SPI
uint8_t led_on[BUFFER_SIZE];				// Buffer to store LED control data for TWI
uint32_t Memory[ADI_TWI_MEMORY_SIZE];		// Memory buffer for TWI operations

// Function to check SPI operation result
static void Check(ADI_SPI_RESULT result)
{
	if(result!=ADI_SPI_SUCCESS)
	{
		printf("Unexpected error\n");
	}
	return;

}

// Function to check TWI operation result
static void Check_TWI(ADI_TWI_RESULT result)
{
	if(result!=ADI_TWI_SUCCESS)
	{
		printf("Unexpected error\n");
	}
	return;
}

/** 
* If you want to use command program arguments, then place them in the following string.
*/
char __argv_string[] = "";

/**
 * @brief Main function that configures SPI0 as the master, performs data transmission via SPI,
 *        and uses TWI2 to control an LED to indicate success.
 *
 * This function is the entry point of the program. It first initializes the SPI0 interface as the master
 * and configures the communication settings. It then sends a set of data (`'a'` to `'e'`) over SPI0.
 * Upon successful transmission, it proceeds to configure TWI2 to communicate with a target device (e.g.,
 * an LED controller), writing data to turn on an LED, indicating the success of the SPI operation.
 *
 *
 * @param [in] argc The number of command-line arguments.
 * @param [in] argv The array of command-line argument strings.
 *
 * @return 0 on success, or a non-zero value if an error occurs during execution.
 */

int main(int argc, char *argv[])

{
	/**
	 * Initialize managed drivers and/or services that have been added to 
	 * the project.
	 * @return zero on success 
	 */
	 adi_initComponents();

	 ADI_SPI_HANDLE Master;		// Handle for the SPI master
	 ADI_SPI_RESULT result;		// Variable to store SPI operation results

	 /* Open SPI */
	 result = adi_spi_Open(DEVICE_ID,ADI_SPI_DIR_TRANSMIT,Buffer,ADI_SPI_UNIDIR_MEMORY_SIZE,&Master);
	 Check(result);

	 /* Set the SPI0 as Master */
	 result = adi_spi_SetasMaster(Master,true);
	 Check(result);

	 /* set the SPI0 Clock */
	 result = adi_spi_SetClock(Master,20u);
	 Check(result);

	 /* Copy the data to the Src_list */
	 for(int32_t i = 0 ; i < LIST_SIZE ;i++)
	 {
		 src_list[i] = (int8_t)'a'+ (int8_t)i;
	 }

	 /* Transmit the data from SPI0 */
	 result = adi_spi_CoreWrite(Master,src_list, LIST_SIZE);
	 if(result == ADI_SPI_SUCCESS)
	 {

		 // If SPI transmission is successful, proceed with TWI communication

		 ADI_TWI_HANDLE twi_2;		// Handle for the TWI interface
		 ADI_TWI_RESULT result_twi;		// Variable to store TWI operation results

		 // Enable TWI2 on Port A (configuration for TWI2 SCL and SDA)

		 *pREG_PORTA_MUX |= TWI2_SCL_EN|TWI2_SDA_EN;
		 *pREG_PORTA_FER |= PORTA_TWI2_EN;

		 // Initialize the LED configuration
		 Led_config Led;
		 Led.register_addr = LED_REG_ADDR;
		 Led.value = LED_SET;

		 // Open the TWI interface (TWI2) as a master
		 Result = adi_twi_Open(TWI_NO,ADI_TWI_MASTER,Memory,ADI_TWI_MEMORY_SIZE,&twi_2);
		 Check_TWI(result_twi);

		 // Set the hardware address of the target device
		 Result = adi_twi_SetHardwareAddress(twi_2,TARGET_ADDRESS);
		 Check_TWI(result_twi);

		 // Set the prescaler value for TWI communication
		 Result = adi_twi_SetPrescale(twi_2,TWI_PRESCALE);
		 Check_TWI(result_twi);

		 // Set the bitrate for TWI communication
		 Result = adi_twi_SetBitRate(twi_2, TWI_BITRATE);
		 Check_TWI(result_twi);

		 // Set the duty cycle for TWI communication
		 Result = adi_twi_SetDutyCycle(twi_2, TWI_DUTYCYCLE);
		 Check_TWI(result_twi);

		 // Store the LED configuration data in led_on[] for transmission
		 led_on[0]=Led.register_addr;
		 led_on[1]=Led.value;

		 // Write data to the target device over TWI
		 Result = adi_twi_Write(twi_2,led_on,(uint32_t)2u,false);
		 Check_TWI(result_twi);

		 // Close the TWI interface
		 Result = adi_twi_Close(twi_2);
		 Check_TWI(result_twi);

	 }

	 // Close the SPI interface after completing the communication
	 result = adi_spi_Close(Master);
	 return 0;
}

