module Hangman
  class ScreenManager
    def paint_hangman (fails_left)
      fails_left=0 if fails_left<0
      puts 

      if fails_left<10

        if fails_left<=8
          puts " ______  "
        else
         puts
       end

        if fails_left<=7
          puts " |    |  "
        else
          puts " |"
        end
      
        if fails_left<=6
          puts " |    O  "
        else
          puts " |"
        end
      
        if fails_left<=3
          puts " |   /|\\"
        elsif fails_left==4
          puts " |   /|"
        elsif fails_left==5
          puts " |   /"
        else
          puts " |"
        end

        if fails_left<=2
          puts " |    |  "
        else
          puts " |"
        end
      
       if fails_left==0
          puts " |   / \\"
        elsif fails_left==1
        puts " |   /"
        else
          puts " |"
        end
      else
        (1..6).each {puts}
      end
      puts "_|_______"
      puts
    end

  end
  
end