# encoding: utf-8
#
# For russian letters on Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
# Include the unicode_utils library. You must first install it by typing
# in console:
#
# gem install unicode_utils
require "unicode_utils"
# On Windows, loading this library can suddenly take a long time
# (up to a minute) if you encounter this problem, connect only
# the required module by writing:
#
# require "unicode_utils/upcase"

require_relative "game"
require_relative "result-out"
require_relative "word-reader"

puts "The Hangman Game"
puts "You need to guess a hidden word"
puts "If you make a mistake 7 times you will lose"
puts "Let's start!"
sleep 1

result = ResultOut.new

word_reader = WordReader.new

begin
  # Checking does ARGS has a word
  puts "Reading hidden word from argument..."
  sleep 1
  game = Game.new(word_reader.read_from_args)
rescue ArgumentError
  begin
    # Cheking file existance
    puts "Failed"
    puts "Reading words from file..."
    sleep 1
    words_file_name = File.dirname(__FILE__) + "/data/words.txt"
    game = Game.new(word_reader.read_from_file(words_file_name))
  rescue SystemCallError
    puts
    puts "There is no argument for Hangman.rb \n"
    puts "File /data/words.txt not found \n"
    abort "Hidden word required. Please, try again"
  end
end

while game.status == 0
  result.print_status(game)
  game.ask_next_letter
end

result.print_status(game)
