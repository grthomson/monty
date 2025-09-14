#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <ctype.h>
#include "monty.h"

static int read_int_between(const char *prompt, int lo, int hi) {
    int x;
    for (;;) {
        printf("%s", prompt);
        if (scanf("%d", &x) == 1 && x >= lo && x <= hi) return x;
        // flush invalid input
        int c; while ((c = getchar()) != '\n' && c != EOF) {}
        printf("Please enter a number between %d and %d.\n", lo, hi);
    }
}

static int read_yes_no(const char *prompt) {
    char buf[16];
    for (;;) {
        printf("%s", prompt);
        if (scanf("%15s", buf) == 1) {
            for (char *p = buf; *p; ++p) *p = (char)tolower(*p);
            if (!strcmp(buf, "y") || !strcmp(buf, "yes")) return 1;
            if (!strcmp(buf, "n") || !strcmp(buf, "no"))  return 0;
        }
        // flush rest of line
        int c; while ((c = getchar()) != '\n' && c != EOF) {}
        printf("Please answer yes or no.\n");
    }
}

int main(void) {
    // seed RNG once
    unsigned seed = (unsigned)time(NULL);
    srand(seed);

    int car    = random_car_door();
    int choice = read_int_between("Choose a door (1, 2, or 3): ", 1, 3);

    int reveal = host_reveal_door(car, choice);
    printf("Host reveals: door %d has a goat behind it.\n", reveal);

    int do_switch = read_yes_no("Would you like to switch doors? (yes/no): ");
    if (do_switch) {
        // the remaining closed door: 1+2+3 = 6
        choice = 6 - choice - reveal;
    }

    if (is_win(car, choice)) {
        printf("You win the car! (car behind door %d)\n", car);
        return 0;
    } else {
        printf("You did not win the car. (car behind door %d)\n", car);
        return 0;
    }
}
