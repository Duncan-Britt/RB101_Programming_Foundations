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

MAX_VALUE = 21
DEALER_MIN = 17
WINNING_SCORE = 5

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
  limit = MAX_VALUE - non_ace_value
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

def display_turn(player_cards, dealer_cards, scores)
  system 'clear'
  puts "\n"
  puts "Player score: #{scores[:player]}. Dealer score: #{scores[:dealer]}"
  puts "\n"
  puts "  Dealer has: #{dealer_cards[0]} and an unknown card"
  puts "  You have: #{print_cards(player_cards)}"
  puts "\n\n"
  puts "  Hit or stay? (h/s)"
  puts "\n"
end

def bust?(value)
  value > MAX_VALUE
end

def display_bust(cards, player_total)
  system 'clear'
  puts "\n\n\n"
  puts "  You bust."
  puts "  Your hand: #{print_cards(cards)}"
  puts "  Total value of #{player_total}"
  puts "\n\n"
end

def display_dealer_bust(dealer_cards, dealer_total)
  system 'clear'
  puts "\n\n\n"
  puts "Dealer busted. You win!"
  puts "His hand was: #{print_cards(dealer_cards)} "\
       "for a total value of #{dealer_total}"
  puts "\n\n"
end

def winner(player_total, dealer_total)
  if player_total > dealer_total
    'You!'
  elsif player_total < dealer_total
    'the dealer.'
  else
    "No one. It's a tie"
  end
end

def declare_winner(player_cards, dealer_cards, player_total, dealer_total)
  system 'clear'
  puts "\n\n\n"
  puts "  Winner is: #{winner(player_total, dealer_total)}"
  puts "  You had #{print_cards(player_cards)} "\
       "for a total value of #{player_total}"
  puts "  The dealer had #{print_cards(dealer_cards)} "\
       "for a total value of #{dealer_total}"
  puts "\n\n"
end

def get_winner(player_total, dealer_total)
  if player_total > dealer_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def update_score(scores, player_total, dealer_total)
  winner = get_winner(player_total, dealer_total)
  return if winner == :tie
  scores[winner] += 1
end

def display_grand_winner(winner)
  puts "The grand winner is the #{winner}!"
  puts "Thanks for playing."
  sleep(2)
end

def play_again?
  puts "Play again? (y)"
  input = gets.chomp.downcase
  if input.start_with?('y')
    true
  else
    false
  end
end

# GAME BEGINS
player_wins = 0
dealer_wins = 0
scores = { player: 0, dealer: 0 }
loop do
  deck = initialize_deck
  player_cards, dealer_cards = initial_hand(deck)

  busted = false
  # PLAYER TURN
  player_total = total_value(player_cards)
  loop do
    display_turn(player_cards, dealer_cards, scores)
    choice = ''
    loop do
      choice = gets.chomp.downcase
      # Validate input
      break if choice.start_with?('h') || choice.start_with?('s')
      display_turn(player_cards, dealer_cards, scores)
      puts "Input must start with 'h' or 's'"
    end
    break if choice.start_with?('s')
    hit!(player_cards, deck)
    player_total = total_value(player_cards)
    if bust?(player_total)
      scores[:dealer] += 1
      display_bust(player_cards, player_total)
      busted = true
      break
    end
  end

  # DEALER TURN
  dealer_total = total_value(dealer_cards)
  loop do
    break if dealer_total >= DEALER_MIN || busted
    hit!(dealer_cards, deck)
    dealer_total = total_value(dealer_cards)
    if bust?(dealer_total)
      scores[:player] += 1
      display_dealer_bust(dealer_cards, dealer_total)
      busted = true
    end
  end

  unless busted
    declare_winner(player_cards, dealer_cards, player_total, dealer_total)
    update_score(scores, player_total, dealer_total)
  end

  if scores[:player] == WINNING_SCORE
    display_grand_winner('player')
    scores = { player: 0, dealer: 0 }
  elsif scores[:dealer] == WINNING_SCORE
    display_grand_winner('dealer')
    scores = { player: 0, dealer: 0 }
  end

  break unless play_again?
end

system 'clear'
