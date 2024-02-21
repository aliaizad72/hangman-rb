# frozen_string_literal: true

# serves as the class that holds the game states
class Game
  attr_accessor :round

  attr_reader :secret_word, :player

  def initialize
    @secret_word = Wordlist.random_word './words.txt'
    @player = Player.new(secret_word)
    intro
    @round = 1
  end

  def play
    until round == 11 || player.guess == secret_word
      puts "Round #{round}:"
      puts "Mystery word: #{player.guess_display}\n\n"
      player.update_guess
      @round += 1
    end

    if player.guess == secret_word
      announce_winner
    else
      announce_death
    end
  end

  def intro
    puts "#{player.name}, we have sentence you to death...but if you are able to guess the mystery word,"
    puts "you will escape unscathed.\n\n"
    puts 'You will have ten rounds.'
    puts 'You can either guess a letter in the word, or the whole word itself.'
    puts 'If your letter guess is right, we will reveal to you where the letters reside in the word.'
    puts "If you choose to guess a word and you are able to guess correctly, you are free immediately.\n\n"
  end

  def announce_winner
    puts 'Congratulations, the gods have given you another chance at life.'
  end

  def announce_death
    puts "The word that killed you was '#{secret_word}'. Unfortunate, but you had your chance."
  end
end

# serves as a class that handles all player-related interactions
class Player
  attr_accessor :guess

  attr_reader :name, :word

  def initialize(word)
    @name = ask_name
    @word = word
    @guess = '_' * word.length # Initial player guess is none correct
  end

  def ask_name
    print 'State your name, prisoner: '
    gets.chomp
  end

  def guess_display
    guess.split('').inject('') { |str, char| "#{str}#{char} " }
  end

  def update_guess
    print "#{name}, enter your guess: "
    input = gets.chomp.downcase
    puts
    replace_chars(input) if word.count_chars.keys.include?(input)
    @guess = input if @word == input
  end

  def replace_chars(char)
    char_ind = word.count_chars[char]
    guess_arr = guess.split('')
    char_ind.each do |ind|
      guess_arr[ind] = char
    end
    @guess = guess_arr.join('')
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
  def count_chars
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
