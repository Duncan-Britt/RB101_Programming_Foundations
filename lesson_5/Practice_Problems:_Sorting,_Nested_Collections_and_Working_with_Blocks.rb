# Practice Problem 1
# arr = ['10', '11', '9', '7', '8']
# new = arr.sort do |a, b|
#   b.to_i <=> a.to_i
# end
# p new

# Practice Problem 2
# books = [
#   {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
#   {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
#   {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
#   {title: 'Ulysses', author: 'James Joyce', published: '1922'}
# ]
# sorted = books.sort_by do |book|
#   book[:published].to_i
# end
# p sorted

# Practice Problem 3
# arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
# puts arr1[2][1][3]
# arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
# puts arr2[1][:third][0]
# arr3 = [['abc'], ['def'], {third: ['ghi']}]
# puts arr3[2][:third][0][0]
# hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
# puts hsh1['b'][1]
# hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
# puts hsh2[:third].key(0)

# Practice Problem 4
# arr1 = [1, [2, 3], 4]
# arr1[1][1] = 4
# p arr1
# arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
# arr2[2] = 4
# p arr2
# hsh1 = {first: [1, 2, [3]]}
# hsh1[:first][2][0] = 4
# p hsh1
# hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
# hsh2[['a']][:a][2] = 4
# p hsh2

# Practice Problem 5
# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }
# sum = 0
# munsters.each do |_, info|
#   sum += info['age'] if info['gender'] == 'male'
# end
# puts sum

# Practice Problem 6
# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }
#
# munsters.each do |k, v|
#   puts "#{k} is a #{v['age']}-year-old #{v['gender']}."
# end

# Practice Problem 7
# a => 2
# b => [3, 8]

# Practice Problem 8
# hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}
# VOWELS = 'AEIOUaeiou'
# hsh.each do |_, array|
#   array.each do |str|
#     str.each_char { |chr| puts chr if VOWELS.include?(chr) }
#   end
# end

# Practice Problem 9
# arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
# new = arr.map do |sub_arr|
#   sub_arr.sort do |a, b|
#     b <=> a
#   end
# end
# p new

# Practice Problem 10
# new = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |e|
#   e.map { |k, v| [k, v+=1] }.to_h
# end
# p new

# Practice Problem 11
# arr = [[2], [3, 5, 7], [9], [11, 13, 15]]
# new = arr.map do |arr|
#   arr.select { |n| (n % 3).zero? }
# end
# p new

# Practice Problem 12

# arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# # expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}
# hash = arr.each_with_object({}) do |sub_arr, hash|
#   hash[sub_arr[0]] = sub_arr[1]
# end
# p hash

# Practice Problem 13

# arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
# new = arr.sort_by do |sub|
#   sub.select { |e| e.odd? }
# end
# p new

# Practice Problem 14
# hsh = {
#   'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
#   'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
#   'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
#   'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
#   'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
# }
# new = hsh.map do |_, info|
#   case info[:type]
#   when 'fruit'
#     info[:colors].map { |e| e.capitalize }
#   when 'vegetable'
#     info[:size].upcase
#   end
# end
# p new

# Practice Problem 15
# arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]
# new = arr.select do |hash|
#   hash.all? do |_, array|
#     array.all? { |n| n.even? }
#   end
# end
# p new

# Practice Problem 16
HEX_CHARS = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f']

def new_UUID
  array = []
  8.times do
    array << HEX_CHARS.sample
  end
  array << '-'
  3.times do
    4.times do
      array << HEX_CHARS.sample
    end
    array << '-'
  end
  12.times do
    array << HEX_CHARS.sample
  end
  array.join
end

p new_UUID

def uuid
  str = '        -    -    -    -            '
  array = str.chars
  array.map! do |ch|
    if ch == '-'
      '-'
    else
      HEX_CHARS.sample
    end
  end
  array.join
end

p uuid
