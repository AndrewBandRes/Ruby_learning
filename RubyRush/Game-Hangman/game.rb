# encoding: utf-8
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

  def get_letters(word)
    raise ArgumentError.new (
      "There is no any word. Try again"
    ) if word == nil || word == ""

    # Change the case of a word to uppercase with UnicodeUtils
    word = UnicodeUtils.upcase(word.encode('UTF-8'))

    return word.split("")
  end

  def status
    return @status
  end

  def next_step(letter)
    letter = UnicodeUtils.upcase(letter)

    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(letter) || @bad_letters.include?(letter)
      return
    end

    if @letters.include?(letter) ||
      (letter == 'Е' && @letters.include?('Ё')) ||
      (letter == 'Ё' && @letters.include?('Е')) ||
      (letter == 'И' && @letters.include?('Й')) ||
      (letter == 'Й' && @letters.include?('И'))
      @good_letters << letter

      @good_letters << 'Ё' if letter == 'Е'
      @good_letters << 'Е' if letter == 'Ё'
      @good_letters << 'Й' if letter == 'И'
      @good_letters << 'И' if letter == 'Й'

      @status = 1 if (letters - good_letters).empty?
    else
      @bad_letters << letter
      @errors += 1

      @status = -1 if @errors >= 7
    end
  end

  def ask_next_letter
    puts "\nInput next letter"

    letter = ""
    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    next_step(letter)
  end

  def errors
    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end
end
