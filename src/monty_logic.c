#include "monty.h"    // update this header to match the prototypes below
#include <stdlib.h>  // rand
#include <assert.h>
#include <stdbool.h>

/*
 * Monty Hall core logic (3-door version).
 *
 * Contracts:
 *  - Call srand(...) ONCE in main() before using these functions.
 *  - Door labels are 1, 2, 3.
 *  - This module contains pure game logic (no I/O).
 *
 * Exposed API:
 *    int  random_car_door(void);
 *    int  host_reveal_door(int car, int choice);
 *    bool is_win(int car, int choice);
 */

/* Uniformly choose the car door in {1,2,3}. Requires srand(...) called once. */
int random_car_door(void) {
    return (rand() % 3) + 1;
}

/* Internal helper: next door in the 1->2->3->1 cycle. */
static inline int next_door(int d) {
    return (d % 3) + 1;
}

/*
 * Choose the door the host reveals.
 * Rules:
 *  - It must NOT be the player's current choice.
 *  - It must have a goat behind it (i.e., not the car).
 *
 * Behavior:
 *  - If the player initially chose the car, either goat door is valid.
 *    We pick deterministically (next door, skipping the car) for testability.
 *  - If the player chose a goat, the identity (1+2+3)=6 yields the unique goat:
 *      reveal = 6 - car - choice
 */
int host_reveal_door(int car, int choice) {
    assert(car    >= 1 && car    <= 3);
    assert(choice >= 1 && choice <= 3);

    if (car == choice) {
        int candidate = next_door(choice);
        if (candidate == car) {
            candidate = next_door(candidate);
        }
        return candidate;  // goat & not 'choice'
    } else {
        return 6 - car - choice; // unique goat & not 'choice'
    }
}

/* True iff the player's choice is the winning (car) door. */
bool is_win(int car, int choice) {
    assert(car    >= 1 && car    <= 3);
    assert(choice >= 1 && choice <= 3);
    return car == choice;
}
