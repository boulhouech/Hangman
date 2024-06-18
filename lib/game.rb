class Game
  attr_accessor :correct_guesses, :remaining_attempts
  attr_reader :option, :random_word

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

  def get_user_guess
    print "Enter a letter: "
    gets.chomp.downcase
  end

  def play_game

  end

end
