#include <time.h>



// function for calculating time
int timer_calc(struct timespec *timer_start, struct timespec *timer_stop, 
                    long long int *time_difference) {
  long long int difference_seconds =  timer_stop->tv_sec - timer_start->tv_sec; 
  long long int difference_nseconds =  timer_stop->tv_nsec - timer_start->tv_nsec; 

  if(difference_nseconds < 0 ) {
    difference_seconds--;
    difference_nseconds += 1000000000; 
  } 
  *time_difference = difference_seconds * 1000000000 + difference_nseconds;
  return !(*time_difference > 0);
}
