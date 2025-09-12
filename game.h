#include <stdio.h>           
#include <stdlib.h>
#include <sys/time.h>
/* sys/time is being taken in to use as a random seed */

/* These are all just function prototypes */
int door_car();
int door_goat(int car, int choice);
int winning(int car, int choice);
