# encoding: utf-8
#
# Class ResultOut for displaying players result on the screen
class ResultOut
  def initialize
    @status_image = []

    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= 7
      file_name = current_path + "/image/#{counter}.txt"

      # Checking of file existance
      begin
        file = File.new(file_name, "r:UTF-8")
        @status_image << file.read
        file.close
      rescue SystemCallError
        @status_image << "\n [ image not found ] \n"
      end

      counter += 1
    end
  end

  def print_hangman(errors)
    puts @status_image[errors]
  end

  def print_status(game)
    cls

    puts
    puts "Word: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Mistakes: #{game.bad_letters.join(", ")}"

    print_hangman(game.errors)

    if game.status == -1
      puts
      puts "You have lost! :("
      puts "Hidden word was: " + game.letters.join("")
      puts
    elsif game.status == 1
      puts
      puts "You have won! :)"
      puts
    else
      puts
      puts "You have " + (7 - game.errors).to_s + " tries left"
      puts
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ""

    for item in letters do
      if good_letters.include?(item)
        result += item + " "        
      else
        result += "__ "
      end
    end

    result
  end

  # Method for cleaning of screen
  # Calls 'clear' for Mac OS/Linux and 'cls' for Windows
  def cls
    system("clear") || system("cls")
  end
end
