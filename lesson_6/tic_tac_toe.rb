require 'pry'
require 'pry-byebug'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals
STARTER = 'choose'

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

# rubocop:disable Metrics/AbcSize
def display_board(brd, p_score, c_score)
  system 'clear'
  puts "You're an #{PLAYER_MARKER}. Computer is an #{COMPUTER_MARKER}"
  puts "Your score: #{p_score}. computer_score: #{c_score}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def endangered_square(brd)
  threaten_lines = WINNING_LINES.select do |line|
    brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1
  end
  unless threaten_lines.empty?
    line_to_attack = threaten_lines.sample
    empty_spot = line_to_attack.select { |num| brd[num] == INITIAL_MARKER }
    return empty_spot[0]
  end
  danger_lines = WINNING_LINES.select do |line|
    brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
    brd.values_at(*line).count(INITIAL_MARKER) == 1
  end
  if danger_lines.empty?
    case
    when brd[5] == ' '
      return 5
    when brd[1] == ' '
      return 1
    when brd[3] == ' '
      return 3
    when brd[7] == ' '
      return 7
    when brd[9] == ' '
      return 9
    else
      return empty_squares(brd).sample
    end
  end
  line_to_defend = danger_lines.sample
  empty_spot = line_to_defend.select { |num| brd[num] == INITIAL_MARKER }
  empty_spot[0]
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = endangered_square(brd)
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def factory
  case STARTER
  when 'choose'
    choose_game
  else
    game(STARTER)
  end
end

def choose_game
  system 'clear'
  prompt "Would you like the computer to start? (y/n)"
  input = gets.chomp
  if input.downcase.start_with?('y')
    game('computer')
  else
    game('player')
  end
end

def alternate_player(player)
  case player
  when 'player'
    'computer'
  when 'computer'
    'player'
  end
end

def place_piece!(brd, player)
  case player
  when 'player'
    player_places_piece!(brd)
  when 'computer'
    computer_places_piece!(brd)
  end
end

def game(current_player, player_score=0, computer_score=0)
  board = initialize_board

  loop do
    display_board(board, player_score, computer_score)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end


  case detect_winner(board)
  when 'Player'
    player_score += 1
  when 'Computer'
    computer_score += 1
  end

  display_board(board, player_score, computer_score)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie."
  end

  if player_score == 5 || computer_score == 5
    prompt "The Grand Winner is #{detect_winner(board)}!"
    return
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  if answer.downcase.start_with?('y')
    game(current_player, player_score, computer_score)
  end
end

factory
prompt "Thanks for playing Tic Tac Toe! Goodbye."
