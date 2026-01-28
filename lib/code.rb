# generate random codes and validates against allowed colors
class Code
  ALLOWED_COLORS = %w[R G B Y O P].freeze

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
end

code = Code.new
p code.generate_code
