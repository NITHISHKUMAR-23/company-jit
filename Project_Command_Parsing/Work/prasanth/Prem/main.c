#include <stdio.h>
#include <string.h>
#include <stdlib.h>
 
FILE*cp;
int command_parsing(char*,int*);
void parameter_parsing(char* arr,int parameter_count,int i);
int main()
{
    int parameter_count = 0;
    char *arr[4];
    arr[0] = "0x20000030";
    arr[1] = "0x20012336";
    arr[2] = "0x20022336";
 
   
    if(command_parsing(arr[0],&parameter_count) != 1)
    {
        printf("failed\n");
    }
   
    char output[1024];
   
    FILE *fp = fopen("D:\\C-practice\\ttl_parser1\\output.txt","a+");
    while (fgets(output, sizeof(output), cp) != NULL) {
       printf("%s",output);
       fprintf(fp,"%s", output);
    }
    fclose(cp);
 
    for(int i=1;i<=parameter_count;i++)
    {
        parameter_parsing(arr[i],parameter_count,i);
   
    while (fgets(output, sizeof(output), cp) != NULL) {
       printf("%s",output);
       fprintf(fp,"%s", output);
    }
    }
}
 
int command_parsing(char*arr,int* parameter_count)
{
   
    char bit_field_command[512];
 
 
        snprintf(bit_field_command, sizeof(bit_field_command), "python D:\\Project_Command_Parsing\\Work\\prasanth\\Prem\\python.py %s %s %s",arr,"false","false");
        cp=popen(bit_field_command,"r");
        char validate[5];
        fgets(validate, sizeof(validate), cp);
        *parameter_count=atoi(validate);
        if((*parameter_count) == 0)
        {
            printf("invalid Command\n");
            return 0;
        }
        printf("%d\n",*parameter_count);
        // fclose(cp);
       
 
    //     else
    //     {
    //         printf("%d",i);
    //         snprintf(bit_field_command, sizeof(bit_field_command), "python3 D:\\C-practice\\ttl_parser1\\parser.py %s %s %d",arr[0],arr[i],i);
    //         cp=popen(bit_field_command,"r");
    //         char validate[1024];
    //     }
    // }
    return 1;
}
void parameter_parsing(char* arr,int parameter_count,int i)
{
    char bit_field_command[512];
    snprintf(bit_field_command, sizeof(bit_field_command), "python D:\\Project_Command_Parsing\\Work\\prasanth\\Prem\\python.py %s %s %d","0x20000030",arr,i);
    cp=popen(bit_field_command,"r");
}
