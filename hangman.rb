# frozen_string_literal: true

# serves as the class that holds the game states
class Game
  attr_accessor :player_guess

  attr_reader :secret_word

  def initialize
    @secret_word = Wordlist.random_word './vocab.txt'
    @player_guess = '_' * secret_word.length # Initial player guess is none correct
  end
end

# serves as a class to provide the words for the game
class Wordlist
  def self.random_word(path)
    File.open(path).readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }.sample
  end
end
