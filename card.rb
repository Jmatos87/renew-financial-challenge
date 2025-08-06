# Represents a playing card with suit and rank
class Card
  attr_reader :suit, :rank
  
  # Define card ranks in ascending order (2 is lowest, Ace is highest)
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades'].freeze
  
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end
  
  # Get numerical value for comparison (Ace = 14, King = 13, etc.)
  def value
    case @rank
    when 'J'
      11
    when 'Q'
      12
    when 'K'
      13
    when 'A'
      14
    else
      @rank
    end
  end
  
  def to_s
    "#{@rank} of #{@suit}"
  end
  
  # Compare cards by value for sorting/comparison
  def <=>(other)
    self.value <=> other.value
  end
end
