#include <stdio.h>
#include "game.h"

int main() {
    int car = door_car();
    int choice;
    int reveal;
    char change;

    /* This function just prints the doors */
    printf("Choose a door, 1, 2 or 3: ");
    scanf("%d", &choice);
    /* I am using the door_goat function given to reveal a goat in a door which has not been chosen */
    reveal = door_goat(car, choice);
    printf("The door %d has a goat behind it.\n", reveal);
    printf("Would you like to switch doors? (yes/no): ");
    /* I used a space before the %c as otherwise it would take the enter from my previous scanf and take that as the input */
    scanf(" %c", &change);
    
    /* If the user changes, then if they would have lost before, then they win, and if they would have won then they lost, I used this information for my if statements */
    if (change == 'y') {
        if (winning(car, choice) == 0) {
            printf("You did not win the car.\n");
        } else {
            printf("You win the car.\n");
        }
    } else if (change == 'n') {
        if (winning(car, choice) == 0) {
            printf("You win the car.\n");
        } else {
            printf("You did not win the car.\n");
        }
    } else {
        printf("Wrong input.\n");
        return 1;
    }
}
