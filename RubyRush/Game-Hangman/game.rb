# frozen_string_literal: true

#
# Main class of Hangman game with methods for continuing the progress
class Game
  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  # Method for definig hidden word
  def get_letters(word)
    # Checking if word is valid
    raise ArgumentError if word.nil? || word == '' || word !~ /^[a-zA-Zа-яА-я]/

    # Changing the case of a word to uppercase
    word.upcase.split('')
  end

  attr_reader :status, :errors, :letters, :good_letters, :bad_letters

  # Method for getting players input
  # Repeats until status == 1 (win) or status == -1 (lose)
  def ask_next_letter
    puts "\nInput next letter"

    letter = ''
    letter = $stdin.gets.chomp while letter == ''

    next_step(letter)
  end

  # Method for evaluation of players letter input
  def next_step(letter)
    letter = letter.upcase

    friends_letters = {
      'Е' => 'Ё',
      'Ё' => 'Е',
      'Й' => 'И',
      'И' => 'Й'
    }

    # Checking if game status has already changed
    # or player repeated same letter again
    return if @status == -1 || @status == 1 || @good_letters.include?(letter) || @bad_letters.include?(letter)
    # If players guess was bad
    return add_bad_letter(letter) unless @letters.include?(letter) || @letters.include?(friends_letters[letter])

    # If players guess was good
    add_good_letter(letter, friends_letters)
  end

  # Method for adding bad letter
  # and increasing count of errors
  def add_bad_letter(letter)
    @bad_letters << letter

    @errors += 1
    # Checking if players has any tries left
    @status = -1 if @errors >= 7
  end

  # Method for adding good letter and it friends
  # and checking if player has won
  def add_good_letter(letter, friends_letters)
    @good_letters << letter
    @good_letters << friends_letters[letter] if friends_letters.key?(letter)

    @status = 1 if (letters - good_letters).empty?
  end
end
