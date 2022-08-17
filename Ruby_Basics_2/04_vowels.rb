ALPHABET = ('a'..'z').to_a
VOWELS = ['a', 'i', 'e', 'o', 'u']
vowel_hash = {}

VOWELS.each { |letter| vowel_hash[letter] = ALPHABET.index(letter) + 1 }

puts vowel_hash
