VALID_CHOICES = %w(rock paper scissors lizard spock)
CHOICE_HASH = {
  'rock' => ['scissors', 'lizard'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'spock' => ['scissors', 'rock'],
  'lizard' => ['spock', 'paper']
}

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  CHOICE_HASH[first].include?(second)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt "You won!"
  elsif win?(computer, player)
    prompt "Computer won"
  else
    prompt "It's a tie"
  end
end

player_score = 0
computer_score = 0

loop do
  choice = ''
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    choice = gets.chomp.downcase

    break if VALID_CHOICES.include?(choice)

    choice = VALID_CHOICES.select do |e|
      if choice.start_with?('s')
        e[0..1] == choice[0..1]
      else
        e[0] == choice[0]
      end
    end

    choice = choice[0]

    break if VALID_CHOICES.include?(choice)

    prompt "That's not a valid choice."
  end
  computer_choice = VALID_CHOICES.sample

  prompt "You choise: #{choice}; Computer chose: #{computer_choice}"

  display_result(choice, computer_choice)

  if win?(choice, computer_choice)
    player_score += 1
  elsif win?(computer_choice, choice)
    computer_score += 1
  end

  prompt "Player score: #{player_score}\n" \
         "Computer score: #{computer_score}"

  if player_score == 5
    prompt "You are the grand winner!"
    break
  elsif computer_score == 5
    prompt "The Computer is the grand winner."
    break
  end

  prompt "Do you want to play again? (y)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
