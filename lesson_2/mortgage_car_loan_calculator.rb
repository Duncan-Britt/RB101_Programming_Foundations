def valid_number?(num)
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

puts <<-MSG
Welcome to the loan calculator.
In order to calculate your monthly interest rate, your loan duration in months, and your monthly payments, we need some information from you. You'll be asked for the amount of the loan, the Annual Percentage Rate (APR) and the duratoin of the loan.

MSG

principle = ''

loop do
  puts "Enter the loan amount:"
  principle = gets.chomp
  break if valid_number?(principle)
  puts "Invalid input."
end

principle = principle.to_f

apr = get_info("Enter the APR:")

apr = apr.to_f/100

duration = get_info("Enter the duration of the loan in years:")

duration = duration.to_f

monthly_ir = apr/12
dur_months = duration * 12

monthly_payment = principle * (monthly_ir / (1 - (1 + monthly_ir)**(-dur_months)))

puts <<-MSG
Your monthly interest rate is #{monthly_ir}.
The duration in months is #{dur_months}.
The monthly payment is #{monthly_payment}.
MSG
