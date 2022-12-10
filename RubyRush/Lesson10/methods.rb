# Method for cleaning of screen
# Calls 'clear' for Mac OS/Linux and 'cls' for Windows
def cls
    system ('clear') || system('cls')
end

# Method for reading of inputted word
def get_letters
    word = ARGV[0]
    if word == nil || word == ''
        abort 'To start game input hidden word as an argument'
    end
    word.encode('UTF-8').split('')
end

# Method that asks the playes for the next letter
def get_user_input
    letter = ''
    while letter == ''
        letter = STDIN.gets.encode('UTF-8').chomp
    end
    letter
end

# Method that returns result of player's guess:
# 0 - if the letter is in the word (or has already been named) and the game continues
# -1 - if the entered letter is not in the word
# 1 - if the whole word is guessed entirely
def check_result(user_input, letters, good_letters, bad_letters)
    if good_letters.include?(user_input) || bad_letters.include?(user_input)
        return 0
    end
    
    if letters.include? user_input
        good_letters << user_input
        if good_letters.uniq.sort == letters.uniq.sort
            return 1
        else
            return 0
        end
    else
        bad_letters << user_input
        return -1
    end
end

# Method for word output
def get_word_for_print(letters, good_letters)
    result = ''
    for item in letters do
        if good_letters.include?(item)
            result += item + ' '
        else
            result += '__ '
        end
    end
    result
end

# Method for status output
def print_status(letters, good_letters, bad_letters, errors)
    puts "\nWord is: #{get_word_for_print(letters, good_letters)}"
    puts "Mistakes (#{errors}): #{bad_letters.join(', ')}"
    if errors >= 7
        puts "You have lost! :("
    else
        if good_letters.uniq.sort == letters.uniq.sort
            puts "You have won! ^^\n\n"
        else
            puts "You have " + (7-errors).to_s + " tries left..."
        end
    end
end
