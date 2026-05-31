# cmd-games

Fun, playable games written entirely in Windows CMD batch script. No installs, no Python, no PowerShell — pure `.bat` files.

## Games

### Number Guesser
Classic hi/lo number guessing game with difficulty levels.
```bat
number-guess.bat easy    REM range 1-50
number-guess.bat hard    REM range 1-1000
```

### Tic Tac Toe
Two-player or vs. a simple AI opponent.
```bat
tictactoe.bat
tictactoe.bat vs-cpu
```

### Hangman
Word guessing game with a built-in word list or custom word file.
```bat
hangman.bat
hangman.bat words.txt    REM use your own word list
```

### Dice Roller RPG
Roll polyhedral dice with styled output. Great for tabletop sessions.
```bat
dice.bat 2d6              REM two six-sided dice
dice.bat 1d20 advantage   REM roll twice, take higher
```

### ASCII Snake
Fully animated snake game in a CMD window (requires Windows 10+).
```bat
snake.bat
```

### Quiz Bowl
Trivia quiz with categories: tech, geography, science, history.
```bat
quiz.bat
quiz.bat tech             REM tech category only
```

### Blackjack
Single-player Blackjack against the dealer.
```bat
blackjack.bat
```

## Controls

Each game shows its own controls. Generally:
- Arrow keys or WASD for movement
- Number keys for menu selection
- `Q` to quit at any time

## Requirements

- Windows 7+ for most games
- Windows 10+ required for `snake.bat` (uses `cls` timing tricks)
- No admin rights needed
