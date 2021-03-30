# frozen_string_literal: true

COMPILE = {
  'PRINT' => 'puts %(=> #{register})',
  'PUSH' => 'stack.push(register)',
  'POP' => 'register = stack.pop',
  'MULT' => 'register *= stack.pop',
  'ADD' => 'register += stack.pop',
  'SUB' => 'register -= stack.pop',
  'DIV' => 'register /= stack.pop',
  'MOD' => 'register %= stack.pop'
}

def number?(obj)
  obj = obj.to_s unless obj.is_a? String
  !!(obj =~ /\A[+-]?\d+(\.[\d]+)?\z/)
end

def minilang(str)
  stack = []
  register = 0
  instructions = str.split
  instructions.each do |command|
    if number?(command)
      register = command.to_i
    elsif COMPILE.keys.include?(command)
      begin
      eval(COMPILE[command])
      rescue
        puts "=> ERROR. Cannot #{command} nil to #{register}"
        break
      end
    else
      puts "=> Error: '#{command}'; No such command exists"
    end
  end
  nil
end

# FURTHER EXPLORATION (3 + (4 * 5) - 7) / (5 % 3)
minilang('3 PUSH 5 MOD PUSH 4 PUSH 5 MULT PUSH 3 ADD PUSH -7 ADD DIV PRINT')
# => 8

# Empty Stack error handling
minilang('5 ADD PRINT')
# => ERROR. Cannot ADD nil to 5

# Syntax error handling
minilang('SCOOBYDOO')
# => Error: 'SCOOBYDOO'; No such command exists
