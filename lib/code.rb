# The Code class is responsible for:
# 1. Generating the secret code
# 2. Comparing a player's guess to the secret
# 3. Tracking exact and color-only matches
class Code
  # These are the only colors allowed in the game.
  # %w creates an array of strings without needing quotes or commas.
  # .freeze prevents accidental modification of the array.
  ALLOWED_COLORS = %w[R G B Y O P].freeze

  # Creates getter and setter methods for:
  # - @secret
  # - @exact_matches
  # - @color_matches
  attr_accessor :secret, :exact_matches, :color_matches

  # When a new Code object is created:
  # - Generate a random secret code
  # - Set match counters to 0
  def initialize
    @secret = generate_code
    @exact_matches = 0
    @color_matches = 0
  end

  # Class method to expose allowed colors.
  # We use self. because this belongs to the class,
  # not to an individual Code instance.
  def self.allowed_colors
    ALLOWED_COLORS
  end

  # Generates an array of 4 random colors.
  # Array.new(4) creates an array with 4 elements.
  # Each element is randomly selected from ALLOWED_COLORS.
  def generate_code
    Array.new(4) { ALLOWED_COLORS.sample }
  end

  # Compares the player's guess to the secret code.
  #
  # Exact match:
  #   Correct color AND correct position.
  #
  # Color match:
  #   Correct color BUT wrong position.
  #
  # We duplicate the arrays to avoid modifying the original
  # secret or guess during comparison.
  def check_color_matches(guess) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    guess_dup = guess.dup
    secret_dup = @secret.dup

    # Reset counters each turn so matches don't accumulate
    @exact_matches = 0
    @color_matches = 0

    # ----- First Pass: Check Exact Matches -----
    # We compare positions directly.
    secret_dup.each_with_index do |color, index|
      next unless color == guess_dup[index]

      @exact_matches += 1

      # Set matched positions to nil so they aren't counted again
      secret_dup[index] = nil
      guess_dup[index] = nil
    end

    # ----- Second Pass: Check Color-Only Matches -----
    # Now we check remaining colors (excluding nil values)
    guess_dup.each do |color|
      next if color.nil?

      next unless secret_dup.include?(color)

      @color_matches += 1

      # Remove the matched color to prevent double counting
      secret_dup[secret_dup.index(color)] = nil
    end
  end

  # Prints the results of the comparison
  def print_results
    puts "✅ Exact matches: #{@exact_matches}"
    puts "⚪ Color matches: #{@color_matches}"
  end
end
