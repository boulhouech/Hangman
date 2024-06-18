class Game
  attr_accessor :correct_guesses, :remaining_attempts
  attr_reader :option, :random_word

  def initialize
    pick_random_word
    @correct_guesses = Array.new(@random_word.length, "_")
    @incorrect_guesses = []
    @remaining_attempts = 6
  end

  def user_option(option)
    @option = option
    until ['1', '2'].include?(@option)
      puts 'Invalid choice. Please choose 1 or 2.'
      @option = gets.chomp
    end

    case @option
    when '1'
      start_new_game
    when '2'
      load_saved_game
    end
  end

  def pick_random_word
    file = File.open("ref.txt", "r")
    words = file.readlines.map(&:chomp).select { |word| word.length >= 5 && word.length <= 12 }
    file.close
    @random_word = words.sample
  end

  def start_new_game
    play_game(@random_word)
  end

  def load_saved_game
    # implement loading saved game logic here
  end

  def play_game(word)
    while @remaining_attempts > 0
      display_game_state(@correct_guesses, @incorrect_guesses, @remaining_attempts)

      guess = get_user_guess

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

  def display_game_state(correct_guesses, incorrect_guesses, remaining_attempts)
    puts "Word: #{correct_guesses.join(" ")}"
    puts "Incorrect guesses: #{incorrect_guesses.join(", ")}"
    puts "Remaining guesses: #{remaining_attempts}"
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
end

game = Game.new
game.user_option(gets.chomp)
