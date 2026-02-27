# generate random codes and validates against allowed colors
class Code
  ALLOWED_COLORS = %w[R G B Y O P].freeze
  attr_accessor :secret, :exact_matches, :color_matches

  def initialize
    @secret = generate_code
    @exact_matches = 0
    @color_matches = 0
  end

  def self.allowed_colors
    ALLOWED_COLORS
  end

  def generate_code
    Array.new(4) { ALLOWED_COLORS.sample }
  end

  def check_color_matches(guess) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    guess_dup = guess.dup
    secret_dup = @secret.dup
    @exact_matches = 0
    @color_matches = 0

    secret_dup.each_with_index do |col1, i|
      next unless col1 == guess_dup[i]

      @exact_matches += 1
      secret_dup[i] = nil
      guess_dup[i] = nil
    end

    guess_dup.each do |col|
      next if col.nil?

      if secret_dup.include?(col)
        @color_matches += 1
        secret_dup[secret_dup.index(col)] = nil
      end
    end
  end

  def print_results
    puts "✅ Exact matches: #{@exact_matches}"
    puts "⚪ Color matches: #{@color_matches}"
  end
end
