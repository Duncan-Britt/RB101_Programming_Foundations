require 'pry'
require 'yaml'

LANGUAGE = 'en'

MESSAGES = YAML.load_file('./calculator_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  puts "=> #{message}"
end

prompt(messages('welcome', 'es'))

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(messages('valid_name', 'es'))
  else
    break
  end
end

def valid_number?(num)
  Float(num) rescue false
end

def operation_to_message(op)
  oper =  case op
          when '1'
            'Adding'
          when '2'
            'Subtracting'
          when '3'
            'Multiplying'
          when '4'
            'Dividing'
          end

  oper
end
prompt "Hi #{name}!"

loop do
  num1 = ''
  loop do
    prompt messages('first_number')
    num1 = gets.chomp

    if valid_number?(num1)
      break
    else
      prompt messages('invalid_number')
    end
  end

  num2 = ''

  loop do
    prompt(messages('second_number'))
    num2 = gets.chomp

    break if valid_number?(num2)
    prompt messages('invalid_number')
  end

  operator_prompt = messages('operator_prompt')

  prompt operator_prompt

  operator = ''
  loop do
    operator = gets.chomp.downcase

    break if %w(1 2 3 4).include?(operator)
    prompt messages('invalid_op')
  end

  prompt "#{operation_to_message(operator)} the two numbers..."

  result =  case operator
            when '1'
              num1.to_i + num2.to_i
            when '2'
              num1.to_i - num2.to_i
            when '3'
              num1.to_i * num2.to_i
            when '4'
              num1.to_f / num2.to_f
            end

  prompt "The result is #{result}"

  prompt(messages('continue?'))
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(messages('goodbye'))
