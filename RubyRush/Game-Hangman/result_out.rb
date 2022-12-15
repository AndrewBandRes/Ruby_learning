# frozen_string_literal: true

# Class ResultOut for displaying players result on the screen
class ResultOut
  def initialize
    @status_image = []

    8.times do |counter|
      file = File.new("#{File.dirname(__FILE__)}/image/#{counter}.txt")
      @status_image << file.read
      file.close
      rescue SystemCallError
        @status_image << "\n [ image not found ] \n"
    end
  end

  def print_hangman(errors)
    puts @status_image[errors]
  end

  def print_status(game)
    cls

    puts "\n Word: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Mistakes: #{game.bad_letters.join(', ')} \n"

    print_hangman(game.errors)
    print_result(game)
  end

  def print_result(game)
    case game.status
    when -1
      puts '\n You have lost! :('
      puts "Hidden word was: #{game.letters.join('')}"
    when 1
      puts 'You have won! :)'
    else
      puts "You have #{7 - game.errors} tries left"
    end
    puts
  end

  def get_word_for_print(letters, good_letters)
    result = ''

    letters.each do |item|
      unless good_letters.include?(item)
        result += '_ '
        next
      end
      result += "#{item} "
    end

    result
  end

  # Method for cleaning of screen
  # Calls 'clear' for Mac OS/Linux and 'cls' for Windows
  def cls
    system('clear') || system('cls')
  end
end
