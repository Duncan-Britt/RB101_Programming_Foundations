require 'yaml'

MESSAGES = YAML.load_file('./mortgage_messages.yml')

def valid_number?(num)
  return false if num.to_f < 0
  Float(num) rescue false
end

def get_info(message)
  puts message
  input = gets.chomp
  unless valid_number?(input)
    puts "Invalid input."
    input = get_info(message)
  end
  input
end

puts MESSAGES['welcome']
loop do
  principle = ''

  loop do
    puts "Enter the loan amount:"
    principle = gets.chomp
    break if valid_number?(principle)
    puts "Invalid input."
  end

  principle = principle.to_f

  apr = get_info("Enter the percent APR:")

  apr = apr.to_f / 100

  duration = get_info("Enter the duration of the loan in years:")

  duration = duration.to_f

  monthly_ir = apr / 12
  dur_months = duration * 12

  monthly_payment = principle *
                    (monthly_ir / (1 - (1 + monthly_ir)**(-dur_months)))

  puts <<-MSG
  Your monthly interest rate is #{monthly_ir * 100}%.
  The duration in months is #{dur_months.to_i}.
  The monthly payment is $#{format('%.2f', monthly_payment)}.
  MSG

  puts "Another calculation? (y)"
  break unless gets.chomp.downcase.start_with?('y')
end

puts "Thanks and goodbye."
