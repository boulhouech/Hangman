require_relative 'hangman'

class Game
  attr_accessor :correct_guesses, :remaining_attempts
  attr_reader :option, :random_word

  def initialize
    pick_random_word
    @correct_guesses = Array.new(@random_word.length, "_")
    @incorrect_guesses = []
    @remaining_attempts = 10
  end

  def user_option(option)
    @option = option
    until ['1', '2'].include?(@option.to_s)
      puts 'Invalid choice. Please choose 1 or 2.'
      @option = gets.chomp
    end

    case @option.to_s
    when '1'
      start_new_game
    when '2'
      load_saved_game
    end
  end

  def pick_random_word
    file_path = "ref.txt" 

    if File.exist?(file_path)
      file = File.open(file_path, "r")
      words = file.readlines.map(&:chomp).select { |word| word.length >= 5 && word.length <= 12 }
      file.close
      @random_word = words.sample
    else
      puts "Error: The file 'ref.txt' was not found."
      exit
    end
  end

  def start_new_game
    play_game(@random_word)
  end

  def play_game(word)
    while @remaining_attempts > 0
      display_game_state(@correct_guesses, @incorrect_guesses, @remaining_attempts)

      puts "Enter 'save' to save the game, or enter a letter to make a guess."
      input = gets.chomp

      if input.downcase == 'save'
        save_game(@correct_guesses, @incorrect_guesses, @remaining_attempts, word)
        return
      else
        guess = input
      end

      if word.include?(guess)
        update_correct_guesses(word, @correct_guesses, guess)
      else
        @incorrect_guesses << guess
        @remaining_attempts -= 1
      end

      if won?(@correct_guesses, word)
        congratulate_user(word)
        return
      end
    end

    if lost?(@remaining_attempts)
      sorry_user(word)
    end
  end

  def display_game_state(correct_guesses, incorrect_guesses, max_incorrect_guesses)
    puts "Word: #{correct_guesses.join(" ")}"
    puts "Incorrect guesses: #{incorrect_guesses.join(", ")}"
    puts "Remaining guesses: #{max_incorrect_guesses}"
    Hangman.draw_it(max_incorrect_guesses)
  end

  def get_user_guess
    print "Enter a letter: "
    gets.chomp.downcase
  end

  def update_correct_guesses(word, correct_guesses, guess)
    word.split("").each_with_index do |letter, index|
      if letter == guess
        correct_guesses[index] = guess
      end
    end
  end

  def won?(correct_guesses, word)
    correct_guesses.join("") == word
  end

  def congratulate_user(word)
    puts "Congratulations, you won! The word was #{word}."
  end

  def lost?(remaining_attempts)
    remaining_attempts == 0
  end

  def sorry_user(word)
    puts "Sorry, you lost. The word was #{word}."
  end

  def save_game(correct_guesses, incorrect_guesses, remaining_attempts, word)
    Dir.mkdir("output") unless Dir.exist?("output")

    save_number = 1
    while File.exist?("output/save_#{save_number}.txt")
      save_number += 1
    end

    filename = "output/save_#{save_number}.txt"
    File.open(filename, 'w') do |file|
      file.puts "Correct Guesses: #{correct_guesses.join(", ")}"
      file.puts "Incorrect Guesses: #{incorrect_guesses.join(", ")}"
      file.puts "Remaining Attempts: #{remaining_attempts}"
      file.puts "Word: #{word}"
    end

    puts "Game saved to #{filename}."
  end

  def load_saved_game
    saved_files = Dir.glob("output/save_*.txt")
    if saved_files.empty?
      puts "No saved games found."
      return
    end

    saved_files.each_with_index do |file, index|
      puts "#{index + 1}. #{file}"
    end

    print "Enter the number of the game you want to load: "
    choice = gets.chomp.to_i

    if choice.between?(1, saved_files.length)
      filename = saved_files[choice - 1]
      File.open(filename, 'r') do |file|
        lines = file.readlines
        correct_guesses = lines[0].split(": ")[1].split(", ")
        incorrect_guesses = lines[1].split(": ")[1].split(", ")
        remaining_attempts = lines[2].split(": ")[1].to_i
        word = lines[3].split(": ")[1].chomp

        @correct_guesses = correct_guesses
        @incorrect_guesses = incorrect_guesses
        @remaining_attempts = remaining_attempts
        @random_word = word

        play_game(@random_word)
      end
    else
      puts "Invalid choice. No game loaded."
    end
  end
end
