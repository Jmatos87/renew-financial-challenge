# Represents a player in the War card game
class Player
  attr_reader :name, :hand
  attr_accessor :eliminated
  
  def initialize(name, hand = [])
    @name = name
    @hand = hand
    @eliminated = false
  end
  
  # Draw the top card from player's hand
  def draw_card
    return nil if @hand.empty?
    @hand.shift
  end
  
  # Add cards to the bottom of player's hand
  def add_cards(cards)
    @hand.concat(cards)
  end
  
  # Check if player has any cards left
  def has_cards?
    !@hand.empty?
  end
  
  # Get number of cards in hand
  def card_count
    @hand.length
  end
  
  # Check if player can participate in war (needs at least 4 cards for war scenario)
  def can_war?
    @hand.length >= 4
  end
  
  # Draw multiple cards for war scenario
  def draw_war_cards(count)
    cards = []
    count.times do
      break if @hand.empty?
      cards << draw_card
    end
    cards
  end
  
  def to_s
    "#{@name} (#{card_count} cards)"
  end
end
