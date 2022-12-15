# frozen_string_literal: true

require_relative 'game'
require_relative 'result_out'
require_relative 'word_reader'

puts 'The Hangman Game'
puts 'You need to guess a hidden word'
puts 'If you make a mistake 7 times you will lose'
puts "Let's start!"
sleep 1

result = ResultOut.new

word_reader = WordReader.new

begin
  # Checking does ARGS has a word
  puts 'Reading hidden word from argument...'
  sleep 1
  game = Game.new(word_reader.read_from_args)
rescue ArgumentError
  begin
    # Cheking file existance
    puts 'Failed'
    puts 'Reading words from file...'
    sleep 1
    words_file_name = "#{File.dirname(__FILE__)}/data/words.txt"
    game = Game.new(word_reader.read_from_file(words_file_name))
  rescue SystemCallError, ArgumentError
    puts 'Failed'
    puts
    puts "There is no argument for hangman.rb \n"
    puts "File /data/words.txt contains invalid word or not found \n"
    abort 'Hidden word required. Please, try again'
  end
end

while game.status.zero?
  result.print_status(game)
  game.ask_next_letter
end

result.print_status(game)
