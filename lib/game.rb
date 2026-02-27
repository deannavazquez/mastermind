require_relative 'code'
class Game
  attr_accessor :player_guess_size

  def initialize
    welcome_message
    @code = Code.new
    @player_turn = 0
  end

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

  def player_guess
    puts "=== Starting player_guess #{@player_turn + 1}/12 ==="
    puts "Enter your guess (4 letters) using these colors: #{Code.allowed_colors}"
    input = gets.chomp
    guess = input.upcase.split(//)
    if valid_choice?(guess)
      @code.check_color_matches(guess)
      @player_turn += 1
    else
      puts '❌ INVALID MOVE! Please enter a valid guess using the allowed colors and format.'
    end
  end

  def valid_choice?(guess)
    # length is exactly 4
    guess.length == 4 && guess.all? { |color| Code.allowed_colors.include?(color) }
  end

  def winner?
    @code.exact_matches == 4
  end

  def draw?
    @player_turn >= 12
  end

  def play
    # main game loop
    loop do
      player_guess
      @code.print_results
      if winner?
        puts "Congratulations! You cracked the code! 🎉  The secret code was: #{@code.secret.join}"
        break
      elsif draw?
        puts "Game over! You've used all your turns. The secret code was: #{@code.secret.join}"
        break
      end
    end
  end
end
