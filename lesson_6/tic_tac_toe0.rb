require 'pry'
require 'pry-byebug'

SPOTS = {
  '1' => 0,
  '2' => 1,
  '3' => 2,
  '4' => 3,
  '5' => 4,
  '6' => 5,
  '7' => 6,
  '8' => 7,
  '9' => 8
}

WINS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def reset_board
  $board = %w(1 2 3 4 5 6 7 8 9)
end

def print_board
  puts <<-MSG

     #{$board[0]} | #{$board[1]} | #{$board[2]}
    ---+---+----
     #{$board[3]} | #{$board[4]} | #{$board[5]}
    ---+---+----
     #{$board[6]} | #{$board[7]} | #{$board[8]}

    MSG
end

def player_choose
  spot = ''

  loop do
    puts "Choose a spot"
    spot = gets.chomp
    break if SPOTS.keys.include?(spot) && $board.include?(spot)
    puts 'Invalid spot. Please enter an available space (1-9).'
  end

  $board[SPOTS[spot]] = 'X'
end

def ai_choose
  left = $board.select do |e|
    e != 'X' && e != 'O'
  end
  x_indices = []
  $board.each_with_index do |e, i|
    x_indices << i if e == 'X'
  end
  o_indices = []
  $board.each_with_index do |e, i|
    o_indices << i if e == 'O'
  end

  num_x_in_WINS = [[0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7]]
  WINS.each_with_index do |win, i|
    x_indices.each do |x_idx|
      num_x_in_WINS[i][0] += win.count(x_idx)
    end
  end

  most_xs_in_WINS = []
  count = 0

  num_x_in_WINS.each do |e|
    if e[0] >= count
      count = e[0]
      most_xs_in_WINS << e[1]
    end
  end
  i = -1
  move = nil
  # binding.pry
  loop do
    break unless most_xs_in_WINS[i]
    move = WINS[most_xs_in_WINS[i]].select do |idx|
      left.any? { |e| SPOTS[e] == idx }
    end.sample
    break if move
    i -= 1
  end
  puts "move: #{move}"
  # binding.pry
  if move
    $board[move] = 'O'
    puts "here"
  else
    $board[SPOTS[left.sample]] = 'O'
  end
end

def winner?
  if WINS.any? do |win|
      win.all? do |idx|
        $board[idx] == 'X'
      end
    end
    return 'Player'
  elsif WINS.any? do |win|
      win.all? do |idx|
        $board[idx] == 'O'
      end
    end
    return 'A.I.'
  else
    false
  end
end

def board_full?
  $board.all? do |e|
    e == 'X' || e == 'O'
  end
end

def game
  reset_board
  loop do
    print_board
    player_choose
    if winner?
      print_board
      puts "#{winner?} won!"
      break
    end
    if board_full?
      print_board
      puts "Draw."
      break
    end
    ai_choose
    if winner?
      print_board
      puts "#{winner?} won!"
      break
    end
  end
  puts "Enter 'p' to play again, or anything else to exit"
  input = gets.chomp
  if input.downcase.start_with?('p')
    game
  end
end

game
