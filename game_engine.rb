require_relative 'deck'
require_relative 'player'

# Main game logic for War card game
class Game
  attr_reader :players, :round_count
  
  def initialize(num_players)
    @num_players = num_players
    @players = []
    @round_count = 0
    @deck = Deck.new
    setup_players
  end
  
  # Set up players and deal cards
  def setup_players
    hands = @deck.deal_to_players(@num_players)
    @num_players.times do |i|
      @players << Player.new("Player #{i + 1}", hands[i])
    end
  end
  
  # Main game loop
  def play
    puts "Starting War Card Game with #{@num_players} players!"
    puts "Each player starts with #{52 / @num_players} cards.\n\n"
    
    display_initial_status
    
    while !game_over?
      @round_count += 1
      puts "\n" + "=" * 50
      puts "ROUND #{@round_count}"
      puts "=" * 50
      
      play_round
      display_round_status
      
      # Remove eliminated players
      @players.reject! { |player| player.eliminated }
      
      # Check for winner after each round
      if winner = check_winner
        puts "\n" + "🔥" * 20
        puts "GAME OVER! #{winner.name} wins with all 52 cards!"
        puts "Total rounds played: #{@round_count}"
        puts "Dont gamble with your company's future, play responsibly! :)"
        puts "🔥" * 20
        break
      end
      
      # Pause for readability (remove in production if needed)
      sleep(1)
    end
  end
  
  private
  
  # Play a single round
  def play_round
    active_players = @players.reject { |p| p.eliminated }
    return if active_players.empty?
    
    # Cards played this round by each player
    round_cards = {}
    cards_in_play = []
    
    # Each player plays their top card
    active_players.each do |player|
      if player.has_cards?
        card = player.draw_card
        round_cards[player] = [card]
        cards_in_play << card
        puts "#{player.name} plays: #{card}"
      else
        player.eliminated = true
        puts "#{player.name} is eliminated (no cards left)!"
      end
    end
    
    # Continue until there's a clear winner or players are eliminated
    while true
      # Find players with highest card value
      max_value = cards_in_play.map(&:value).max
      winners = active_players.select do |player| 
        !player.eliminated && round_cards[player] && round_cards[player].last&.value == max_value
      end
      
      # If only one winner, they take all cards
      if winners.length == 1
        winner = winners.first
        all_cards = round_cards.values.flatten
        winner.add_cards(all_cards.shuffle)
        puts "\n#{winner.name} wins the round with #{round_cards[winner].last}!"
        puts "#{winner.name} takes #{all_cards.length} cards."
        break
      end
      
      # War scenario - tied players need to play more cards
      if winners.length > 1
        puts "\nWAR! #{winners.map(&:name).join(' and ')} tied with #{round_cards[winners.first].last.rank}!"
        
        war_cards = []
        new_face_up_cards = []
        
        winners.each do |player|
          if player.card_count >= 4
            # Play 3 cards face down, then 1 face up
            war_hand = player.draw_war_cards(4)
            if war_hand.length == 4
              face_down = war_hand[0..2]
              face_up = war_hand[3]
              
              round_cards[player].concat(war_hand)
              war_cards.concat(war_hand)
              new_face_up_cards << face_up
              
              puts "#{player.name} plays 3 cards face down and #{face_up} face up"
            else
              # Player doesn't have enough cards - play remaining cards
              round_cards[player].concat(war_hand)
              war_cards.concat(war_hand)
              if !war_hand.empty?
                new_face_up_cards << war_hand.last
                puts "#{player.name} plays remaining #{war_hand.length} cards, last card: #{war_hand.last}"
              end
            end
          else
            # Player has few cards - play all remaining
            remaining_cards = []
            while player.has_cards?
              remaining_cards << player.draw_card
            end
            
            if !remaining_cards.empty?
              round_cards[player].concat(remaining_cards)
              war_cards.concat(remaining_cards)
              new_face_up_cards << remaining_cards.last
              puts "#{player.name} plays all remaining #{remaining_cards.length} cards, last card: #{remaining_cards.last}"
            else
              player.eliminated = true
              puts "#{player.name} has no cards left and is eliminated!"
            end
          end
        end
        
        # Update active players and cards in play for next iteration
        active_players = @players.reject { |p| p.eliminated }
        cards_in_play = new_face_up_cards
        
        # If only one player left, they win
        if active_players.length <= 1
          break
        end
      end
    end
  end
  
  # Display initial game status
  def display_initial_status
    puts "Initial card distribution:"
    @players.each { |player| puts "  #{player}" }
  end
  
  # Display status after each round
  def display_round_status
    puts "\nCurrent standings:"
    active_players = @players.reject { |p| p.eliminated }
    active_players.sort_by { |p| -p.card_count }.each do |player|
      puts "  #{player}"
    end
    
    eliminated = @players.select { |p| p.eliminated }
    if !eliminated.empty?
      puts "\nEliminated players:"
      eliminated.each { |player| puts "  #{player.name}" }
    end
  end
  
  # Check if game is over (one player has all cards or only one player left)
  def game_over?
    active_players = @players.reject { |p| p.eliminated }
    active_players.length <= 1 || active_players.any? { |p| p.card_count == 52 }
  end
  
  # Check for winner
  def check_winner
    active_players = @players.reject { |p| p.eliminated }
    
    # Winner if they have all 52 cards
    winner = active_players.find { |p| p.card_count == 52 }
    return winner if winner
    
    # Winner if they're the last player standing
    active_players.length == 1 ? active_players.first : nil
  end
end
