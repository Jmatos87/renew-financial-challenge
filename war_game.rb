#!/usr/bin/env ruby

require_relative 'game_engine'

# Main entry point for the War Card Game
class WarCardGame
  def self.start
    puts "Welcome to the War Card Game!"
    puts "=" * 40
    
    # Get number of players
    num_players = get_number_of_players
    
    # Create and start the game
    game_engine = Game.new(num_players)
    game_engine.play
  end
  
  private
  
  # Get valid number of players from user input
  def self.get_number_of_players
    loop do
      print "Enter number of players (2-4): "
      input = gets.chomp.to_i
      
      if input >= 2 && input <= 4
        return input
      else
        puts "Invalid input. Please enter a number between 2 and 4."
      end
    end
  rescue Interrupt
    puts "\nGame cancelled. Goodbye!"
    exit
  end
end

# Start the game if this file is run directly
if __FILE__ == $0
  WarCardGame.start
end
