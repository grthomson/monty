#include <stdio.h>
#include "game.h"

/**
 *	Generates a random number between 1-3 which is used to select which
 *	door the car is behind.
 */
int door_car()
{

    // The number of microseconds into the current second of time.
    // Better than simply using the current time in seconds since well
    // be running the simulation many times per second which will give us
    // the same seed if we only use seconds.
    struct timeval tv;
    struct timezone tz;
    gettimeofday(&tv, &tz);

    // Use the microseconds as a seed for random. This should provide sufficient
    // entropy
	srand(tv.tv_usec);

	// Return a random number between 1-3
    return ( (rand() % 3) + 1 );

}

/* I removed print doors as it was not needed at all */

/**
 *	Return a door which the player didn't select AND has a goat behind it
 *
 *	car: 	The door which the car in behind
 *	choice: The door the player chose
 */
int door_goat(int car, int choice)
{
	
	// The magic formula doesn't work if the player picks right on their
	// first guess so we need to just pick one
	if( car == choice )
	{
		return ( ( ++choice % 3 ) + 1 );
	}
	else
	{
		// The "maqic" formula below should always give the door which has
		// a goat behind it, assuming the car isn't behind the door they chose
		return ( 6 - car - choice );
	}

}

int winning (int car, int choice) {
/* This function returns whether the choice has won or lost */
    if (car == choice) {
        return 0;
    } else { 
        return 1;
    }
}


