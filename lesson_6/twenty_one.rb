# frozen_string_literal: true

CARD_VALUES = {
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  '10' => 10,
  'Jack' => 10,
  'Queen' => 10,
  'King' => 10,
  'Ace' => :A
}

def initialize_deck
  CARD_VALUES.keys * 4
end

def ace_value(ace_count, max=11)
  if ace_count <= max
    11 + ace_count - 1
  else
    ace_count
  end
end

def hand_value(non_ace_value, ace_count=0)
  return non_ace_value if ace_count.zero?
  limit = 21 - non_ace_value
  ace11_max = limit - 10
  non_ace_value + ace_value(ace_count, ace11_max)
end

def not_aces(cards)
  cards.reject { |card| card == 'Ace' }
end

def cards_value(cards) # doesn't take aces
  cards.reduce(0) do |sum, card|
    sum + CARD_VALUES[card]
  end
end

def total_value(cards)
  non_ace_cards = not_aces(cards)
  ace_count = cards.count('Ace')
  non_ace_value = cards_value(non_ace_cards)
  hand_value(non_ace_value, ace_count)
end

def random!(deck) # returns and removes random card from DECK
  deck.delete_at(rand(deck.length))
end

def initial_hand(deck)
  player_cards = []
  dealer_cards = []
  player_cards << random!(deck)
  dealer_cards << random!(deck)
  player_cards << random!(deck)
  dealer_cards << random!(deck)
  return player_cards, dealer_cards
end

# perhaps not necessary
def hit!(player, deck)
  player.unshift(random!(deck))
end

def print_cards(cards)
  return "#{cards[0]} and #{cards[1]}" if cards.count == 2
  cards = cards.dup
  n_before_and = cards.length - 2
  result = cards.shift
  n_before_and.times do
    result += ", #{cards.shift}"
  end
  result + ", and #{cards.shift}"
end

def display_turn(player_cards, dealer_cards)
  system 'clear'
  puts "\n\n\n"
  puts "  Dealer has: #{dealer_cards[0]} and an unknown card"
  puts "  You have: #{print_cards(player_cards)}"
  puts "\n\n"
  puts "  Hit or stay? (h/s)"
  puts "\n"
end

def bust?(cards)
  total_value(cards) > 21
end

def display_bust(cards)
  system 'clear'
  puts "\n\n\n"
  puts "  You bust."
  puts "  Your hand: #{print_cards(cards)}"
  puts "  Total value of #{total_value(cards)}"
  puts "\n\n"
end

def display_dealer_bust(dealer_cards)
  system 'clear'
  puts "\n\n\n"
  puts "Dealer busted. You win!"
  puts "His hand was: #{print_cards(dealer_cards)} for a total value of #{total_value(dealer_cards)}"
  puts "\n\n"
end

def winner(player_cards, dealer_cards)
  if total_value(player_cards) > total_value(dealer_cards)
    'You!'
  elsif total_value(player_cards) < total_value(dealer_cards)
    'the dealer.'
  else
    "No one. It's a tie"
  end
end

def declare_winner(player_cards, dealer_cards)
  system 'clear'
  puts "\n\n\n"
  puts "  Winner is: #{winner(player_cards, dealer_cards)}"
  puts "  You had #{print_cards(player_cards)} for a total value of #{total_value(player_cards)}"
  puts "  The dealer had #{print_cards(dealer_cards)} for a total value of #{total_value(dealer_cards)}"
  puts "\n\n"
end

# GAME BEGINS
loop do
  deck = initialize_deck
  player_cards, dealer_cards = initial_hand(deck)

  busted = false
  # PLAYER TURN
  loop do
    display_turn(player_cards, dealer_cards)
    choice = ''
    loop do
      choice = gets.chomp.downcase
      # Validate input
      break if choice.start_with?('h') || choice.start_with?('s')
      display_turn(player_cards, dealer_cards)
      puts "Input must start with 'h' or 's'"
    end
    break if choice.start_with?('s')
    hit!(player_cards, deck)
    if bust?(player_cards)
      display_bust(player_cards)
      busted = true
      break
    end
  end

  # DEALER TURN
  loop do
    break if busted
    break if total_value(dealer_cards) >= 17
    hit!(dealer_cards, deck)
    if bust?(dealer_cards)
      display_dealer_bust(dealer_cards)
      busted = true
    end
  end

  declare_winner(player_cards, dealer_cards) unless busted

  puts "Play again? (y)"
  input = gets.chomp.downcase
  break unless input.start_with?('y')
end

system 'clear'
