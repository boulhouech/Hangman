class Hangman
  def self.draw_it(lives)
     # Gallows
      puts " _______"
      puts "|       |"
      puts "|       |"
      puts "|       |"
      puts "|       |"
      puts "|_______|"

      # Head
      puts "|       |"
      puts "|   #{'O' if lives <= 9}   |"
      puts "|"

      # Body
      if lives <= 8
        puts "|   #{'|' if lives <= 7}  |"
        puts "|  #{'/' if lives <= 6}  |"
      end

      # Rope
      if lives <= 6
        puts "|  #{'\\' if lives <= 5}  |"
      end

      # Legs
      if lives <= 5
        puts "| /   #{'\\' if lives <= 4} |"
      end

      # Feet
      if lives <= 4
        puts "|/     #{'\\' if lives <= 3} |"
      end

      # Final touches
      if lives <= 3
        puts "|_______|"
      end
    end

    draw_hangman(10)


  end
end
