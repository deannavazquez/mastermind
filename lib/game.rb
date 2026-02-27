# require_relative loads a Ruby file from the same project directory.
# We need access to the Code class so the Game can create a secret code
# and check guesses against it.
require_relative 'code'

# The Game class controls:
# 1. Player interaction (input/output)
# 2. Turn tracking
# 3. Win / lose logic
# 4. The main game loop
class Game
  # Creates getter and setter for player_guess_size
  # (Currently not used in this version — could be removed if unnecessary)
  MAX_TURNS = 12
  # When a new Game object is created:
  # - Display welcome message
  # - Create a new Code object (this generates the secret code)
  # - Set the player's turn counter to 0
  def initialize
    welcome_message
    @code = Code.new
    @player_turn = 0
  end

  # Displays game instructions and rules.
  # This method is separated to keep initialize clean.
  def welcome_message
    puts 'Welcome to Mastermind 🎯'
    puts
    puts 'The computer has chosen a secret code made up of 4 colors.'
    puts 'Your goal is to guess the code before you run out of turns.'
    puts 'You have 12 turns to crack it.'
    puts
    puts 'You have 6 colors to choose from:'
    puts 'R (Red), G (Green), B (Blue), Y (Yellow), O (Orange), P (Pink)'
    puts
    puts 'Colors may repeat in the code.'
    puts 'You have a limited number of attempts to crack it.'
    puts
    puts 'To make a guess, type in a 4 single letter color code and press Enter.'
    puts 'Enter your guess as 4 letters with no spaces (e.g. RGBY).'
    puts 'Uppercase or lowercase is fine.'
    puts
    puts 'Good luck! 🧠✨'
  end

  # Handles one turn of player input.
  # This method:
  # - Prompts the player
  # - Converts input into usable format
  # - Validates the guess
  # - Sends the guess to Code for evaluation
  def player_guess
    puts "=== Starting player_guess #{@player_turn + 1}/12 ==="
    puts "Enter your guess (4 letters) using these colors: #{Code.allowed_colors}"

    # gets.chomp removes newline
    # upcase ensures input works regardless of case
    # split(//) converts string into array of characters
    input = gets.chomp
    guess = input.upcase.split(//)

    if valid_choice?(guess)
      # Send guess to Code class for match calculation
      @code.check_color_matches(guess)

      # Increment turn counter only for valid guesses
      @player_turn += 1
    else
      puts '❌ INVALID MOVE! Please enter a valid guess using the allowed colors and format.'
    end
  end

  # Validates player input.
  # A valid guess:
  # - Must be exactly 4 letters
  # - Each letter must be one of the allowed colors
  def valid_choice?(guess)
    guess.length == 4 &&
      guess.all? { |color| Code.allowed_colors.include?(color) }
  end

  # Player wins if all 4 positions match exactly.
  def winner?
    @code.exact_matches == 4
  end

  # Player loses if 12 turns are used.
  def draw?
    @player_turn >= MAX_TURNS
  end

  # The main game loop.
  # This controls the full flow of the game.
  #
  # Loop runs until:
  # - Player wins
  # - Player runs out of turns
  def play
    loop do
      player_guess
      @code.print_results

      if winner?
        puts 'Congratulations! You cracked the code! 🎉'
        puts "The secret code was: #{@code.secret.join}"
        break

      elsif draw?
        puts "Game over! You've used all your turns."
        puts "The secret code was: #{@code.secret.join}"
        break
      end
    end
  end
end
