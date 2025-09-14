# Monty Hall (C)

A tiny, friendly command-line simulator of the **Monty Hall problem** (3 doors).  
Play it interactively or run a Monte Carlo to see why **switching ≈ 2/3 wins**.

## Build

You’ll need a C compiler and `make`.

- **Linux/macOS:** `gcc` or `clang` + `make` (usually preinstalled or via package manager).
- **Windows (recommended):** [MSYS2] with MinGW-w64 GCC + Make.
  - Install MSYS2, then in the **UCRT64** shell:
    ```bash
    pacman -Syu
    pacman -S --needed mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-make
    ```
  - Ensure `C:\msys64\ucrt64\bin` is on your PATH.

Build commands:

```bash
make         # release build (default)
make debug   # with sanitizers & debug symbols
```

Binary: `./monty` (Windows: `monty.exe`)

## Play (interactive)

```
./monty
```

You’ll pick a door (1–3), the host shows a goat, then you decide to switch or stay.

## Simulation (Monte Carlo Method)

```
# default: 3000 trials per strategy
scripts/monty_carlo_simulation.sh

# custom trials (here 10,000)
scripts/monty_carlo_simulation.sh -n 10000
```

The script prints win counts & percentages for switch vs stay, and appends to `simulation_summary.csv.`

## Layout (Post-build)
```
monty
├── include
│   └── monty.h
├── src
│   ├── main.c
│   └── monty_logic.c
├── scripts
│   └── monty_hall_simulation.sh
├── README.md
├── LICENSE
├── build
└── monty.exe
```

## Notes

RNG is seeded once; core logic is isolated in monty_logic.c.

When two reveal doors are valid, the host picks one deterministically (easier testing).

make debug enables Address/Undefined sanitizers (handy for catching bugs).

## Troubleshooting

make: command not found → install Make (see Windows notes above).

Compiler not found → install GCC/Clang and ensure it’s on PATH.

VS Code squiggles → select your compiler in C/C++: Select IntelliSense Configuration.


                                      ,,~~--___---,
                                     /            .~,
                               /  _,~             )
                              (_-(~)   ~, ),,,(  /'
                               Z6  .~`' ||     \ |
                               /_,/     ||      ||
                         ~~~~~~~~~~~~~~~W`~~~~~~W`~~~~~~~~~
