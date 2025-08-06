# War Card Game

A command-line implementation of the classic War card game in Ruby, supporting 2-4 players.

## Game Rules

1. A standard 52-card deck is divided evenly among players
2. Players play cards simultaneously each round
3. Highest card wins all played cards
4. When cards tie, a "war" occurs - players play 3 cards face down, then 1 face up
5. Game continues until one player has all 52 cards
6. Players are eliminated if they run out of cards
7. Ace is the highest rank, followed by King, Queen, Jack, 10-2

## How to Run

1. Make sure you have Ruby installed on your system
2. Navigate to the game directory
3. Run the game:
   ```bash
   ruby war_game.rb
   ```
4. Follow the prompts to select number of players (2-4)
5. Watch the game play out automatically!

## Game Features

- **Automatic gameplay**: No user input required during rounds
- **Multiple players**: Supports 2-4 players
- **War scenarios**: Handles tied cards with proper war mechanics
- **Player elimination**: Players are removed when they run out of cards
- **Clear output**: Shows round-by-round progress and game state
- **Proper card ranking**: Ace high, suits irrelevant

## File Structure

- `war_game.rb` - Main entry point and game launcher
- `game.rb` - Core game logic and round management
- `player.rb` - Player class with hand management
- `deck.rb` - Deck creation, shuffling, and dealing
- `card.rb` - Card representation and comparison logic

## Example Output

