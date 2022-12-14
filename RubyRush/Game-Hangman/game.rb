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
    ) if word == nil || word == "" || !(word =~ /^[a-zA-Zа-яА-я]/)

    # Change the case of a word to uppercase with UnicodeUtils
    word = UnicodeUtils.upcase(word.encode('UTF-8'))

    return word.split("")
  end

  def status
    return @status
  end

  def next_step(letter)
    letter = UnicodeUtils.upcase(letter)
    
    friends_letters = {
      'Е' => 'Ё',
      'Ё' => 'Е', 
      'Й' => 'И', 
      'И' => 'Й' 
    } 

    return if @status == -1 || @status == 1
    return if @good_letters.include?(letter) || @bad_letters.include?(letter)
    
    if !(@letters.include?(letter) || @letters.include?(friends_letters[letter]))
      @bad_letters << letter
      
      @errors += 1
      return @status = -1 if @errors >= 7
      
      return
    end
    
    @good_letters << letter  
    @good_letters << friends_letters[letter] if friends_letters.has_key?(letter)
    
    @status = 1 if (letters - good_letters).empty?
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
