class Players
  attr_reader :players, :name

  def initialize(name)
    @name = name
    @players = []
  end

  def players_having_roles
    puts "Puzzle Giver Enter Your Name"
    puzzle_giver = gets.chomp.capitalize
    @players[0] << puzzle_giver

    puts "Puzzle Guesser Enter Your Name"
    puzzle_guesser = gets.chomp.capitalize
    @players[1] << puzzle_guesser
  end
end
