class Main
  def initialize
    @game = Game.new
  end

  def start_game
  puts "Welcome to the game!"
  puts "Would you like to:"
  puts "  1. Start a new game"
  puts "  2. Load a saved game"
  print "Enter your choice (1 or 2): "

    choice = gets.chomp.to_i
    @game.user_option(choice)
  end
end

main = Main.new
main.start
