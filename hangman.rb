# frozen_string_literal: true

require 'pry-byebug'

# serves as the class that holds the game states
class Game
  attr_accessor :player_guess, :round

  attr_reader :secret_word, :secret_word_chars

  def initialize
    intro
    @secret_word = Wordlist.random_word './vocab.txt'
    @player_guess = '_' * secret_word.length # Initial player guess is none correct
    @round = 1
  end

  def play
    until round == 9 || player_guess == secret_word
      puts "Round #{round}:"
      puts "Mystery word: #{display_player_guess}\n\n"
      print 'Enter your guess: '
      char = gets.chomp
      @player_guess = guess_char_replace(@player_guess, char)
      @round += 1
    end
  end

  def intro
    puts 'We have sentence you to death...but if you are able to guess the mystery word,'
    puts "you will escape unscathed.\n\n"
    puts 'You will have eight rounds.'
    puts 'You can either guess a letter in the word, or the whole word itself.'
    puts 'If your letter guess is right, we will reveal to you where the letters reside in the word.'
    puts "If you choose to guess a word and you are able to guess correctly, you are free immediately.\n\n"
  end

  def display_player_guess
    player_guess_array = @player_guess.split('')
    to_display = ''
    player_guess_array.each do |char|
      to_display += "#{char} "
    end
    to_display
  end

  def guess_char_replace(string, char)
    return string unless secret_word.char_index_map.keys.include?(char)

    ind_array = secret_word.char_index_map[char]
    str_array = string.split('')

    ind_array.each do |ind|
      str_array[ind] = char
    end
    str_array.join('')
  end
end

# serves as a class to provide the words for the game
class Wordlist
  def self.random_word(path)
    File.open(path).readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }.sample
  end
end

# extending string to incorporate several specific methods
class String
  def char_index_map
    arr = split('')
    hash = {}
    arr.each_with_index do |char, ind|
      hash[char] ||= []
      hash[char].push(ind)
    end
    hash
  end
end

Game.new.play
