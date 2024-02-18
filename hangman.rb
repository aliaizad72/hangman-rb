# frozen_string_literal: true

# serves as the class that holds the game states
class Game
  attr_accessor :player_guess

  attr_reader :secret_word

  def initialize
    @secret_word = Wordlist.random_word './vocab.txt'
    @player_guess = '_' * secret_word.length # Initial player guess is none correct
  end

  def play
    intro
  end

  def intro
    puts 'We have sentence you to death...but if you are able to guess the mystery word,'
    puts "you will escape unscathed.\n\n"
    puts 'You will have eight rounds.'
    puts 'You can either guess a letter in the word, or the whole word itself.'
    puts 'If your letter guess is right, we will reveal to you where the letters reside in the word.'
    puts 'If you choose to guess a word and you are able to guess correctly, you are free immediately.'
  end
end

# serves as a class to provide the words for the game
class Wordlist
  def self.random_word(path)
    File.open(path).readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }.sample
  end
end

Game.new.play
