# frozen_string_literal: true

class Game
  def initialize
    @secret_word = Dictionary.random_word
  end
end

class Player
end

# serves as a class to provide the words for the game
class Dictionary
  def self.random_word
    File.open('./vocab.txt').readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }.sample
  end
end

puts Dictionary.random_word
