# Mastermind

A command-line implementation of the classic Mastermind code-breaking game built in Ruby.

## About

Mastermind is a code-breaking game where you try to guess your opponent's secret code within a limited number of turns. Each turn, you receive feedback about your guess - whether colors are in the correct position or just present in the code but in the wrong position.

## How to Play

1. The computer generates a random secret code using 4 colored pegs
2. You have 12 turns to guess the code
3. After each guess, you receive feedback:
   - Exact matches: correct color in the correct position
   - Color matches: correct color but in the wrong position
4. Use the feedback to make strategic guesses and crack the code!

## Installation
```bash
git clone https://github.com/yourusername/mastermind.git
cd mastermind
```

## Usage
```bash
ruby mastermind.rb
```

## Features

- Interactive command-line gameplay
- Color-coded feedback system
- 12 turns to crack the code
- Computer-generated random codes

## Built With

- Ruby

## What I Learned

- Implemented Object-Oriented Programming principles in Ruby, creating classes with distinct responsibilities
- Practiced encapsulation by separating game logic from user interface code
- Worked with arrays and conditionals to build the feedback system for comparing guesses against the secret code
  
## Acknowledgments

- Part of [The Odin Project](https://www.theodinproject.com/) curriculum
