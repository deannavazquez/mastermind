# generate random codes and validates against allowed colors
class Code
  ALLOWED_COLORS = %w[R G B Y O P].freeze
  attr_accessor :secret

  def initialize
    welcome_message
    @secret = generate_code
    player_guess
    p @secret
  end

  def welcome_message
    puts '🎯 Welcome to Mastermind!'
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

  def generate_code
    Array.new(4) { ALLOWED_COLORS.sample }
  end

  def player_guess
    i = 1
    loop do
      break if i > 12 || @secret == guess

      puts "=== Starting player_guess #{i}/12 ==="
      puts "Enter your guess (4 letters) using these colors: #{ALLOWED_COLORS}"
      input = gets.chomp
      guess = input.upcase.split(//)
      if valid_choice?(guess)
        check_color_matches(@secret, guess)
        i += 1
      else
        puts 'INVALID MOVE!'
        player_guess
      end
    end
  end

  def valid_choice?(guess)
    # length is exactly 4
    guess.length == 4 && guess.all? { |color| ALLOWED_COLORS.include?(color) }
  end

  def check_color_matches(secret, guess)
    guess_dup = guess.dup
    secret_dup = secret.dup

    secret_dup.dup.each_with_index do |col1, i|
      next unless col1 == guess_dup[i]

      puts "exact match at position #{i}"
      secret_dup[i] = nil
      guess_dup[i] = nil
    end

    guess_dup.each_with_index do |col, i|
      next if col.nil?

      if secret_dup.include?(col)
        puts 'color match'
        secret_dup[secret_dup.index(col)] = nil
      else
        puts 'no match'
      end
    end
  end
end

Code.new
