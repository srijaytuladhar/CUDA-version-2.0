#include <stdio.h>
#include <cuda_runtime_api.h>
#include "timer.c"

/*********************************************************
 * 
 * 
 * To Compile:
 * nvcc -o cuda_password_2_initials_4_digits cuda_password_2_initials_4_digits.cu
 * 
 * 
 * To Run:
 * ./cuda_password_2_initials_4_digits
 * 
 * 
 *********************************************************/

/* password_match_checker function */
__device__ int password_match_checker(char *password_trial) {
    
    char assigned_password_1[] = "BV7842";      // 1 of 4 passwords
    char assigned_password_2[] = "ES2107";      // 2 of 4 passwords
    char assigned_password_3[] = "HR2332";      // 3 of 4 passwords
    char assigned_password_4[] = "RB9669";      // 4 of 4 passwords

    char *attempt_1 = password_trial;
    char *attempt_2 = password_trial;
    char *attempt_3 = password_trial;
    char *attempt_4 = password_trial;
    
    char *password_1 = assigned_password_1;
    char *password_2 = assigned_password_2;
    char *password_3 = assigned_password_3;
    char *password_4 = assigned_password_4;

    while(*attempt_1 == *password_1) {
        if(*attempt_1 == '\0')
        {
            printf("%s\n", assigned_password_1);
            break;
        }

        attempt_1++;
        password_1++;
    }
        
    while(*attempt_2 == *password_2) {
        if(*attempt_2 == '\0')
        {
            printf("%s\n", assigned_password_2);
            break;
        }

        attempt_2++;
        password_2++;
    }

    while(*attempt_3 == *password_3) {
        if(*attempt_3 == '\0')
        {
            printf("%s\n", assigned_password_3);
            break;
        }

        attempt_3++;
        password_3++;
    }

    while(*attempt_4 == *password_4) {
        if(*attempt_4 == '\0')
        {
            printf("%s",assigned_password_1);
            return 1;
        }

        attempt_4++;
        password_4++;
    }
    
    return 0;

}

/* kernel_function */
__global__ void  kernel_function() {
    
    char digit_1, digit_2, digit_3, digit_4;
 
    char asg_password[7];         // assigned password with size 7 
    asg_password[6] = '\0';       // for terminating the string
    
    int loop_1 = blockIdx.x+65;
    int loop_2 = threadIdx.x+65;

    char firstValue = loop_1;
    char secondValue = loop_2;
        
    asg_password[0] = firstValue;       // 1st letter of the password
    asg_password[1] = secondValue;      // 2nd letter of the password
    for(digit_1 ='0'; digit_1<='9'; digit_1++){
        for(digit_2 ='0'; digit_2<='9'; digit_2++){
            for(digit_3 ='0'; digit_3<='9'; digit_3++){
                for(digit_4 ='0'; digit_4<='9'; digit_4++){
                    asg_password[2] = digit_1;       // 3rd letter of the password
                    asg_password[3] = digit_2;       // 4th letter of the password
                    asg_password[4] = digit_3;       // 5th letter of the password
                    asg_password[5] = digit_4;       // 6th letter of the password
                    if(password_match_checker(asg_password)) {
                        //printf("\n Password Matched!!");      // declared to print message but is not used
                    }
                }
            } 
        }
    }
}


/* main function */
int main() {

    // for time (start)   
    struct timespec timer_start, timer_stop;   
    long long int time_taken_for_execution;
    
    clock_gettime(CLOCK_MONOTONIC, &timer_start);
    printf("\n===============================================================================\n");
    printf("!! MATCHED PASSWORD !! \n");
    printf("===============================================================================\n\n"); 
    
    kernel_function <<<26,26>>>();
    cudaThreadSynchronize();

    
    // for time (end)
    clock_gettime(CLOCK_MONOTONIC, &timer_stop);
    timer_calc(&timer_start, &timer_stop, &time_taken_for_execution);
    
    // output of time taken for execution  is displayed
    printf("\n\n===============================================================================\n");
    printf("!! TIME TAKEN FOR EXECUTION !! \n");
    printf("===============================================================================\n\n");
    printf("Nanoseconds: %lld\n", time_taken_for_execution); 
    printf("Seconds: %0.9lf\n\n", ((time_taken_for_execution/1.0e9))); 
    //printf("Minutes: %0.4lf\n", ((time_taken_for_execution/1.0e9)/60));
    //printf("Hours: %0.2lf\n\n", ((time_taken_for_execution/1.0e9)/3600)); 
    

    return 0;
}



