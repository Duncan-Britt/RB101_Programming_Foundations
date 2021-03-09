def prompt(message)
  puts "=> #{message}"
end

prompt "Welcome to Calculator"

prompt "What's the first number?"
num1 = gets.chomp.to_i

prompt "Whats the second number?"
num2 = gets.chomp.to_i

prompt num2
prompt "What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp.downcase

if operator == '1'
  result = num1.to_i + num2.to_i
elsif operator == '2'
  result = num1.to_i - num2.to_i
elsif operator == '3'
  result = num1.to_i * num2.to_i
else
  result = num1.to_f / num2.to_f
end

prompt "The result is #{result}"
