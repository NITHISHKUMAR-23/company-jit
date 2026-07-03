/*
 * FreeRTOS Kernel V10.4.3 LTS Patch 2
 * Copyright (C) 2020 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software. If you wish to use our Amazon
 * FreeRTOS name, please do so in a fair use way that does not cause confusion.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * http://www.FreeRTOS.org
 * http://aws.amazon.com/freertos
 *
 * 1 tab == 4 spaces!
 */

/* Portions Copyright (c) 2024 Analog Devices, Inc. All rights reserved. */

#if defined(_MISRA_2004_RULES) || defined(_MISRA_2012_RULES)
#pragma diag(push)
#ifdef _MISRA_2012_RULES
#else
#pragma diag(suppress:misra_rule_5_1:"FreeRTOS uses identifiers > 31 characters")
#pragma diag(suppress:misra_rule_8_7:"Symbol has global scope as it is used externally")
#endif /* _MISRA_2004_RULES */
#endif /* _MISRA_RULES */

/* Standard includes. */
#include <stdio.h>
#include <builtins.h>



/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"





/* Demo app includes. */
#include "partest.h"
#include "flash.h"
#include "BlockQ.h"
#include "death.h"
#include "PollQ.h"
#include "recmutex.h"
#include "StaticAllocation.h"

/* CCES includes */
#include "adi_initialize.h"


/* The priorities assigned to the tasks. */
#define mainFLASH_TASK_PRIORITY			( tskIDLE_PRIORITY + 1u )
#define mainBLOCK_Q_PRIORITY			( tskIDLE_PRIORITY + 3u )
#define mainQUEUE_POLL_PRIORITY		        ( tskIDLE_PRIORITY + 2u )
#define mainCHECK_TASK_PRIORITY			( tskIDLE_PRIORITY + 4u )
#define mainCREATOR_TASK_PRIORITY 	        ( tskIDLE_PRIORITY + 3u )
#define TIME_SLICE                          2


/* The check task uses the sprintf function so requires a little more stack. */
#define mainCHECK_TASK_STACK_SIZE		( configMINIMAL_STACK_SIZE + 50u )

/* Dimension the buffer used to write the error flag string. */
#define mainMAX_FLAG_STRING_LEN		        ( 32 )

/* The time between cycles of the 'check' task. */
#define mainCHECK_DELAY				( ( TickType_t ) 5000 / portTICK_PERIOD_MS )

/* Error status flag. */
static unsigned int ulErrorFlags = 0u;

/*-----------------------------------------------------------*/


/*
 * Configure the hardware as necessary to run this demo.
 */
static void prvSetupHardware( void );

/*
 * Prints pass/fail information and clears flags.
 */
static void prvPrintInformation( void );

/*
 * Checks the status of all the demo tasks then prints a message to terminal
 * IO.  The message will be either PASS or a message that describes which of the
 * standard demo tasks an error has been discovered in.
 */
static void vCheckTask( void *pvParameters );

/*
 * Checks that all the demo application tasks are still executing without error
 * - as described at the top of the file.  Called by vCheckTask().
 */
static void prvCheckOtherTasksAreStillRunning( void );

/*-----------------------------------------------------------*/

/*----------------Below is my altered tasks section-------------------------------------------*/
/* Function prototypes for each concept */
void timeSlicingTask1(void *pvParameters);
void timeSlicingTask2(void *pvParameters);
void priorityTaskHigh(void *pvParameters);
void priorityTaskLow(void *pvParameters);
void semaphoreTask(void *pvParameters);
static void mutexTask(void *pvParameters);
void messageQueueSenderTask(void *pvParameters);
void messageQueueSenderTask2(void *pvParameters);
void messageQueueReceiverTask(void *pvParameters);
void printMessage(void *parameters);
void printMessageForHeapMemoryAlloation(void *pvParameters);
void threadFunction(void *pvParameters);


// Define the size of the message to allocate
#define MSG_SIZE 100

/* Global variables */
QueueHandle_t xQueue;
SemaphoreHandle_t xSemaphore;
SemaphoreHandle_t xMutex;
SemaphoreHandle_t count;

volatile uint32_t msg_flag = 0;
volatile uint32_t global_var = 0;
volatile uint32_t global_value=0;
TaskHandle_t  task = NULL;
TaskHandle_t  task2= NULL;
volatile uint32_t execution=10;
static uint32_t flag=0;

volatile uint32_t task1BurstTime = 8;
volatile uint32_t task2BurstTime = 10;
/*******************************Above is my altered section ********************************/


int main(int argc, char *argv[])
{
	/* Initialize managed drivers and/or services */
	adi_initComponents();

//    /* Configure the hardware ready to run the demo. */
//    prvSetupHardware();

//
//    /* Create a subset of the standard demo tasks. */
//    vStartLEDFlashTasks( mainFLASH_TASK_PRIORITY );
//    vStartPolledQueueTasks( mainQUEUE_POLL_PRIORITY );
//    vStartRecursiveMutexTasks();
//    vStartBlockingQueueTasks( mainBLOCK_Q_PRIORITY );
//    vStartStaticallyAllocatedTasks();
//
//    /* Start the tasks defined within this file/specific to this demo. */
//    xTaskCreate( vCheckTask, "Check", mainCHECK_TASK_STACK_SIZE, NULL, mainCHECK_TASK_PRIORITY, NULL );
//
//    /* The death demo tasks must be started last as the sanity checks performed
//	require knowledge of the number of other tasks in the system. */
//    vCreateSuicidalTasks( mainCREATOR_TASK_PRIORITY );


    /* --------Integration of my code ---------*/

    /* Create tasks demonstrating Time Slicing and Round Robin Scheduling with same priority*/
    xTaskCreate(timeSlicingTask1, "TimeSlice1", configMINIMAL_STACK_SIZE, NULL, 1, NULL);
    xTaskCreate(timeSlicingTask2, "TimeSlice2", configMINIMAL_STACK_SIZE, NULL, 1, NULL);

    /* Create tasks with different priorities */
    xTaskCreate(priorityTaskLow, "LowPriority", configMINIMAL_STACK_SIZE, NULL, 2, &task);
    xTaskCreate(priorityTaskHigh, "HighPriority", configMINIMAL_STACK_SIZE, NULL, 3,&task);

    /* Semaphore example */
    xSemaphore = xSemaphoreCreateBinary();
    if (xSemaphore != NULL)
    {
    	uint32_t param1;
    	param1=1;
    	uint32_t param1_ptr=(uint32_t)&param1;
    	uint32_t param2;
    	param2=2;
    	uint32_t param2_ptr=(uint32_t)&param2;
        // Create tasks
        xTaskCreate(semaphoreTask, "SemaphoreTask1", configMINIMAL_STACK_SIZE, (void *)param1_ptr, 2, NULL);
        xTaskCreate(semaphoreTask, "SemaphoreTask2", configMINIMAL_STACK_SIZE, (void *)param2_ptr, 2, NULL);
    }

    /* Mutex example */
    xMutex = xSemaphoreCreateMutex();
    xTaskCreate(mutexTask, "MutexTask1", configMINIMAL_STACK_SIZE, NULL, 2, NULL); //priority inheritance mechanism.
    xTaskCreate(mutexTask, "MutexTask2", configMINIMAL_STACK_SIZE, NULL, 3, NULL);

    /* Message Queue example along with pipe-->if one task is handled then it is pipe*/
    xQueue = xQueueCreate(5, sizeof(int));
    xTaskCreate(messageQueueSenderTask, "QueueSender", configMINIMAL_STACK_SIZE, NULL, 2, NULL);
    xTaskCreate(messageQueueSenderTask2, "QueueSender", configMINIMAL_STACK_SIZE, NULL, 2, NULL);

    uint32_t i;
    i=0;
    while(i<5)
    {
    xTaskCreate(messageQueueReceiverTask, "QueueReceiver", configMINIMAL_STACK_SIZE, NULL, 2, NULL);
    i++;
    }

    /*Thread process*/
    xTaskCreate(threadFunction,"Task1",configMINIMAL_STACK_SIZE,NULL,2,&task2);

    /*Dynamic memory allocation*/
    printMessageForHeapMemoryAlloation(NULL);

    /* ------- My Task RTOS section --------*/


    /* Start the scheduler. */
    vTaskStartScheduler();





    printf("end end");
    /* If all is well then this line will never be reached.  If it is reached
    then it is likely that there was insufficient (FreeRTOS) heap memory space
    to create the idle task.  This may have been trapped by the malloc() failed
    hook function, if one is configured. */
    for( ;; )
    {
    	; /* Infinite loop */
    }
}

/*-----------------------------------------------------------*/

#if ( configSUPPORT_STATIC_ALLOCATION == 1 )
/* RTOS memory */
static StaticTask_t xIdleTaskTCB;
static StackType_t uxIdleTaskStack[ configMINIMAL_STACK_SIZE ];

void vApplicationGetIdleTaskMemory(StaticTask_t ** ppxIdleTaskTCBBuffer, StackType_t ** ppxIdleTaskStackBuffer, uint32_t * pulIdleTaskStackSize)
{
    *ppxIdleTaskTCBBuffer   = &xIdleTaskTCB;
    *ppxIdleTaskStackBuffer = uxIdleTaskStack;
    *pulIdleTaskStackSize   = configMINIMAL_STACK_SIZE;
}

/*
 * Get Memory sizes for timer task.
 */
void vApplicationGetTimerTaskMemory( StaticTask_t **ppxTimerTaskTCBBuffer, StackType_t **ppxTimerTaskStackBuffer, uint32_t *pulTimerTaskStackSize );

#if ( configUSE_TIMERS == 1 )
/* configUSE_STATIC_ALLOCATION and configUSE_TIMERS are both set to 1, so the
application must provide an implementation of vApplicationGetTimerTaskMemory()
to provide the memory that is used by the Timer service task. */
void vApplicationGetTimerTaskMemory( StaticTask_t **ppxTimerTaskTCBBuffer, StackType_t **ppxTimerTaskStackBuffer, uint32_t *pulTimerTaskStackSize )
{
/* If the buffers to be provided to the Timer task are declared inside this
function then they must be declared static - otherwise they will be allocated on
the stack and so not exists after this function exits. */
static StaticTask_t xTimerTaskTCB;
static StackType_t uxTimerTaskStack[ configTIMER_TASK_STACK_DEPTH ];

	/* Pass out a pointer to the StaticTask_t structure in which the Timer
	task's state will be stored. */
	*ppxTimerTaskTCBBuffer = &xTimerTaskTCB;

	/* Pass out the array that will be used as the Timer task's stack. */
	*ppxTimerTaskStackBuffer = uxTimerTaskStack;

	/* Pass out the size of the array pointed to by *ppxTimerTaskStackBuffer.
	Note that, as the array is necessarily of type StackType_t,
	configMINIMAL_STACK_SIZE is specified in words, not bytes. */
	*pulTimerTaskStackSize = configTIMER_TASK_STACK_DEPTH;
}
#endif /* configUSE_TIMERS == 1 */
#endif /* configSUPPORT_STATIC_ALLOCATION == 1 */

/*----------------------------------------------------------------------------------------------------------------*/

static void prvSetupHardware( void )
{
    /* Initialise the LEDs. */
    vParTestInitialise();
}

/*----------------------------------------------------------------------------------------------------------------*/

static void prvCheckOtherTasksAreStillRunning( void )
{
    if( xAreBlockingQueuesStillRunning() != pdTRUE )
    {
        ulErrorFlags |= 0x01u;
    }

    if ( xArePollingQueuesStillRunning() != pdTRUE )
    {
        ulErrorFlags |= 0x02u;
    }

    if( xIsCreateTaskStillRunning() != pdTRUE )
    {
        ulErrorFlags |= 0x04u;
    }

    if( xAreRecursiveMutexTasksStillRunning() != pdTRUE )
    {
        ulErrorFlags |= 0x08u;
    }

    if( xAreStaticAllocationTasksStillRunning() != pdTRUE )
    {
        ulErrorFlags |= 0x10u;
    }
}

/*----------------------------------------------------------------------------------------------------------------*/

void vApplicationStackOverflowHook( TaskHandle_t xTask, char * pcTaskName )
{
	( void ) pcTaskName;
	( void ) xTask;

	/* Run time stack overflow checking is performed if
	configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook
	function is called if a stack overflow is detected. */
	taskDISABLE_INTERRUPTS();
	for( ;; )
	{
		; /* Infinite loop */
	}
}

/*----------------------------------------------------------------------------------------------------------------*/

void vAssertCalled( const char * pcFile, unsigned long ulLine )
{
    ( void ) pcFile;
    ( void ) ulLine;

    portDISABLE_INTERRUPTS();
    while ( 1 )
    {
        __builtin_NOP();
    }

}

/*----------------------------------------------------------------------------------------------------------------*/

static void prvPrintInformation( void )
{
    if (ulErrorFlags)
    {
        printf("Test failed\n");
        ulErrorFlags = 0u;
    }
    else
    {
        printf("Test passed\n");
    }
}

/*----------------------------------------------------------------------------------------------------------------*/

static void vCheckTask( void *pvParameters )
{
	TickType_t xLastExecutionTime;

    xLastExecutionTime = xTaskGetTickCount();

    for( ;; )
    {
     /* Delay until it is time to execute again. */
        vTaskDelayUntil( &xLastExecutionTime, mainCHECK_DELAY );

     /* Check all the other tasks to see if the error flag needs updating. */
        prvCheckOtherTasksAreStillRunning();

     /* print the test result */
        prvPrintInformation();
    }
}
/*--------------------- My Task takes place from here -------------------------------------------------------------------------------------------*/

/* Task implementing Time Slicing and Round Robin */

void timeSlicingTask1(void *pvParameters)
{
	while (task1BurstTime > 0) {
	        if (task1BurstTime > TIME_SLICE) {
	            printf("Task 1 is running for %d ms.\n", TIME_SLICE);
	            printf("\n");
	            task1BurstTime -= TIME_SLICE;
	        } else {
	            printf("Task 1 is running for %d ms (final burst).\n", task1BurstTime);
	            printf("\n");
	            task1BurstTime = 0; // Mark as complete
	        }
	        // Delay for 2 ms (simulating time slice)
	        vTaskDelay(pdMS_TO_TICKS(TIME_SLICE));
	    }
}


void timeSlicingTask2(void *pvParameters)
{
	   while (task2BurstTime > 0) {
	        if (task2BurstTime > TIME_SLICE) {
	            printf("Task 2 is running for %d ms.\n", TIME_SLICE);
	            printf("\n");
	            task2BurstTime -= TIME_SLICE;
	        } else {
	            printf("Task 2 is running for %d ms (final burst).\n", task2BurstTime);
	            printf("\n");
	            task2BurstTime = 0; // Mark as complete
	        }
	        // Delay for 2 ms (simulating time slice)
	        vTaskDelay(pdMS_TO_TICKS(TIME_SLICE));
	    }


}
/*-----------------------------------------------------------*/
/* High priority task */
void priorityTaskHigh(void *pvParameters)
{
    uint8_t i;
    i=0;
	while (execution)
    {
        printf("High priority task running\n");
        printf("\n");
        vTaskDelay(pdMS_TO_TICKS(2));
        if( i == 5 )
       	    {
       	        vTaskDelete(NULL);
       	    }
        i++;
        execution--;
    }



}

/*-----------------------------------------------------------*/
/* Low priority task */
void priorityTaskLow(void *pvParameters)
{
    uint8_t i;
    i=0;
	while (execution)
    {
        printf("Low priority task running\n");
        printf("\n");
        vTaskDelay(pdMS_TO_TICKS(1));

        if( i == 5 )
           	    {
           	        vTaskDelete(NULL);
           	    }
            i++;
            execution--;
    }


}

/*-----------------------------------------------------------*/
/* Task using Semaphore */
void semaphoreTask(void *pvParameters)
{
    uint32_t local_data;
	flag = *(uint32_t*)pvParameters;
	printf("%d is the initial status of the flag");
	printf("\n");
    while (execution)
    {

		if (xSemaphoreTake(xSemaphore, 0) == pdTRUE)
        {
            printf("Semaphore taken by SemaphoreTask\n");
            printf("\n");
            local_data = global_value;
            local_data++;
 			global_value =local_data;
 			printf("data: %d\n",local_data);
 			printf("\n");
 			printf("Task %d is done accessing the resource\n" ,flag);
 			vTaskDelay(pdMS_TO_TICKS(1/10));
            xSemaphoreGive(xSemaphore);
            printf("Semaphore is given\n");

        }
	    else
	    {
	        // If unable to take the semaphore, add a short delay
	        vTaskDelay(pdMS_TO_TICKS(0.5));
	    }
        execution--;
        vTaskDelay(pdMS_TO_TICKS(1));
        flag=0;

    }
}

/*-----------------------------------------------------------*/

/* Task using Mutex */
static void mutexTask(void *pvParameters)
{

	while (execution)
	{
        if (xSemaphoreTake(xMutex, 0) == pdTRUE)
        {
            volatile uint32_t shared_var = 0;  // Move shared_var inside to prevent race conditions
            shared_var = global_var;
            shared_var++;
            global_var = shared_var;
            printf("Mutex task is running and");
            printf("Global variable value: %u\n", global_var);
            xSemaphoreGive(xMutex);
        }
        else
        {
            printf("Mutex task - I am waiting in the lobby\n");
        }

        execution--;
        vTaskDelay(pdMS_TO_TICKS(1));
	}
}

/*-----------------------------------------------------------*/
/* Sender task for Message Queue with pipe too- with one task */
void messageQueueSenderTask(void *pvParameters)
{
    int msg = 100;
    while (execution)
    {
        if (xQueueSend(xQueue, &msg ,0) == pdTRUE)
        {
            printf("Message sent to Queue: %d\n", msg);
        }
        execution--;
        vTaskDelay(pdMS_TO_TICKS(1));  // 1 second delay
    }
}

/* Sender task for Message Queue with pipe too- with one task */
void messageQueueSenderTask2(void *pvParameters)
{
    int msg = 120;
    while (execution)
    {
        if (xQueueSend(xQueue, &msg, 0) == pdTRUE)
        {
            printf("Message sent to Queue: %d\n", msg);
        }
        execution--;
        vTaskDelay(pdMS_TO_TICKS(1));  // 1 second delay
    }
}


/*-----------------------------------------------------------*/
/* Receiver task for Message Queue with pipe too*/
void messageQueueReceiverTask(void *pvParameters)
{
    int receivedMsg;
    while (execution)
    {
        if (xQueueReceive(xQueue, &receivedMsg, 0) == pdTRUE)
        {
            printf("Message received from Queue: %d\n", receivedMsg);
        }
        execution--;
        vTaskDelay(pdMS_TO_TICKS(1));  // 1 second delay
    }
}



/*****************************Dynamic memory allocation****************************/
void printMessage(void *parameters) {
	 // Allocate memory for the message from the heap
	    char *msg_ptr = (char *)pvPortMalloc(MSG_SIZE * sizeof(char));

	    if (msg_ptr == NULL) {
	        printf("Heap memory allocation failed\n");
	        vTaskDelete(NULL); // Delete task if memory allocation fails
	    }

	    while (execution) {

	        if (msg_flag == 1) {
	            printf("Heap allocated");

	            // Print the amount of free heap memory
	            printf("Free heap (bytes): %u\n", xPortGetFreeHeapSize());

	            // Free buffer, set pointer to null, and clear flag
	            if (msg_ptr != NULL) {
	                vPortFree(msg_ptr);
	                msg_ptr = NULL;
	            }

	            msg_flag = 0;
	        }
            execution--;
	        vTaskDelay(pdMS_TO_TICKS(1));
	    }
}

void printMessageForHeapMemoryAlloation(void *pvParameters)
{
    // Creating a task to check the status of
	BaseType_t task = xTaskCreate(printMessage, "Print Message", configMINIMAL_STACK_SIZE, NULL, 1, NULL);

    if (task == pdPASS) {
        printf("Task created successfully\n");
        printf("\n");
    } else {
        printf("Failed to create task\n");
    }

    // Print the current free heap size after the task creation
    printf("Free heap after task creation: %u bytes\n", xPortGetFreeHeapSize());


}

void threadFunction(void *pvParameters)
{

	while(execution)
	{
		        // Print current state of the task using eTaskGetState
		        eTaskState taskState = eTaskGetState(task2);

		        // Print the state of the task
		        switch(taskState)
		        {
		            case eReady:
		                printf("Thread is in Ready state\n");
		                printf("\n");
		                break;
		            case eRunning:
		                printf("Thread is in Running state\n");
		                printf("\n");
		                break;
		            case eBlocked:
		                printf("Thread is in Blocked state\n");
		                printf("\n");
		                break;
		            case eSuspended:
		                printf("Thread is in Suspended state\n");
		                printf("\n");
		                break;
		            case eDeleted:
		                printf("Thread is in Deleted state\n");
		                printf("\n");
		                break;
		            default:
		                printf("Unknown state\n");
		                printf("\n");
		                break;
		        }
                 execution--;
		        // Add a delay to simulate task activity
		        vTaskDelay(pdMS_TO_TICKS(1)); // Delay
	}



}



#if defined(_MISRA_2004_RULES) || defined(_MISRA_2012_RULES)
#pragma diag(pop)
#endif
