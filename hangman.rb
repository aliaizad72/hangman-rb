# frozen_string_literal: true

list_file = File.open('./vocab.txt')

word_list = list_file.readlines.map(&:chomp).select { |word| word.length > 4 && word.length < 13 }
