# PRACTICE PROBLEM 1

# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# counter = 0
# h = flintstones.each_with_object({}) do |e, hash|
#   hash[e] = counter
#   counter += 1
# end
# p h

# PRACTICE PROBLEM 2

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
#
# p ages.values.reduce(:+)

# PRACTICE PROBLEM 3

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
#
# p ages.select! {|k,v| v < 100 }

# PRACTICE PROBLEM 4

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
#
# min_age = nil
# ages.each do |k, v|
#   min_age = v unless min_age
#   min_age = v if v <= min_age
# end
# p min_age

# or do this

# ages.values.min

# PRACTICE PROBLEM 5

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
#
# name_idx = nil
# counter = 0
# flintstones.any? do |e|
#   name_idx = counter if e.start_with?('Be')
#   counter += 1
#   e.start_with?('Be')
# end
# p name_idx

# # or do this

# flintstones.index { |name| name[0, 2] == 'Be' }

# PRACTICE PROBLEM 6

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
#
# p flintstones.map! { |e| e[0..2]}

# PRACTICE PROBLEM 7

# statement = "The Flintstones Rock"
#
# char_frequency = {}
# unique_chars = statement.split.join.chars.uniq # create array of unique chars w/o spaces
#
# unique_chars.each do |char|
#   char_count = 0
#   for ch in statement.chars
#     char_count += 1 if char == ch
#   end
#   char_frequency[char] = char_count
# end
#
# p char_frequency
#
# # or use count method
#
# statement_array = statement.split.join.chars
# other_hash = statement_array.each_with_object({}) do |chr, hash|
#   hash[chr] = statement.chars.count(chr)
# end
#
# p other_hash

# PRACTICE PROBLEM 9

# class String
#   def titleize
#     self.split.map {|word| word.capitalize}.join(' ')
#   end
# end
#
# words = "the flintstones rock"
# p words.titleize

# PRACTICE PROBLEM 10

def get_age_group(age)
  case
  when age < 18
    'kid'
  when age > 64
    'senior'
  else
    'adult'
  end
end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

family_members_keys = munsters.keys
family_members_keys.each do |key|
  family_member = munsters[key]
  age = family_member['age']
  family_member['age_group'] = get_age_group(age)
end

p munsters
