class Main
  def initialize
    @game = Game.new
  end

  def start_game
    puts "Welcome To Hangman Game\n"
    puts "Type 'N' if you want to start new game\n"
    puts "Type 'S' if you want to load saved games\n"

    output = gets.chomp.upcase
    @game.user_option(output)
  end
end

main = Main.new
main.start
