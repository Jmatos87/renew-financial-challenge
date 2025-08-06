require_relative 'card'

# Represents a deck of playing cards
class Deck
  attr_reader :cards
  
  def initialize
    @cards = []
    create_deck
    shuffle!
  end
  
  # Create a standard 52-card deck
  def create_deck
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
  end
  
  # Shuffle the deck
  def shuffle!
    @cards.shuffle!
  end
  
  # Deal cards evenly to players
  def deal_to_players(num_players)
    cards_per_player = @cards.length / num_players
    player_hands = Array.new(num_players) { [] }
    
    @cards.each_with_index do |card, index|
      player_hands[index % num_players] << card
    end
    
    player_hands
  end
  
  def empty?
    @cards.empty?
  end
  
  def size
    @cards.length
  end
end
