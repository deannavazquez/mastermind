# main.rb is the entry point of the program.
# This is the file we run to start the game.
#
# It connects everything together but does NOT contain
# game logic itself. That lives inside the Game class.

# require_relative loads a file relative to this file’s location.
# We load the Game class so we can create and run the game.
require_relative 'lib/game'

# Create a new Game object.
# This triggers:
# - The welcome message
# - Creation of a new secret code
game = Game.new

# Start the main game loop.
# This keeps the program running until the player wins or loses.
game.play
