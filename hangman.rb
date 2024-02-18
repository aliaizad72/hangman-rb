# frozen_string_literal: true

# serves as the class that holds the game states
class Game
  def initialize
    @secret_word = Wordlist.random_word
  end
end

class Player
end

# serves as a class to provide the words for the game
class Wordlist
  def self.random_word
    File.open('./vocab.txt').readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }.sample
  end
end

puts Wordlist.random_word
