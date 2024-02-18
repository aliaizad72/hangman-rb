# frozen_string_literal: true

class Game
end

class Player
end

# serves as a class to provide the words for the game
class Dictionary
  attr_reader :wordlist

  def initialize(path)
    @wordlist = File.open(path).readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }
  end

  def random_word
    @wordlist.sample
  end
end

puts Dictionary.new('./vocab.txt').random_word
