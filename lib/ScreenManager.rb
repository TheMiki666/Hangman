
module Hangman
  class ScreenManager
    require 'colorize'

    def present_info (guessing_word, guessed_letters, failed_letters, tries_left, last_letter)
      present_guessing_word(guessing_word, last_letter)
      present_guessed_letters(guessed_letters)
      present_failed_letters(failed_letters)
      present_tries_left(tries_left)
      puts
    end

    def complain
      puts "That is not a valid character!".colorize(:yellow)
    end

    def ask_for_letter
      puts "What is your next letter?"
    end

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

    private

    def present_guessing_word (word, last_letter='')
      (0..word.length-1).each do |i|
        if word[i] == last_letter
          print word[i].colorize(:green)
        else
          print word[i]
        end
        print " "
      end
      print "                 |  "
    end

    def present_guessed_letters (word)
      (0..word.length-1).each do |i|
        print word[i].colorize(:green)
        print " "
      end
      print " |  "
    end

    def present_failed_letters (word)
      (0..word.length-1).each do |i|
        print word[i].colorize(:red)
        print " "
      end
      print " |  "
    end

    def present_tries_left (tries)
      print "Tries left: "
      case tries
      when 0
        color = :red
      when 3, 2, 1
        color = :yellow
      else
        color = :white
      end
      print tries.to_s.colorize(color)
      puts
    end
  
  end
  
end