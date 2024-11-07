
module Hangman
  class ScreenManager
    require 'colorize'

    # Language constants
    ENGLISH = 0 # Default language
    SPANISH = 1

    attr_accessor :language

    def initialize(language=ENGLISH)
      @language=language
    end

    def present_info (guessing_word, guessed_letters, failed_letters, tries_left, last_letter)
      present_guessing_word(guessing_word, last_letter)
      present_guessed_letters(guessed_letters)
      present_failed_letters(failed_letters)
      present_tries_left(tries_left)
      puts
    end

    def greet
      puts
      if @language==SPANISH
        puts "************".colorize(:blue)
        puts "* AHORCADO *".colorize(:blue)
        puts "************".colorize(:blue)
        paint_hangman(0)
        puts
        puts "Pulsa enter para empezar."
      else
        puts "***********".colorize(:blue)
        puts "* HANGMAN *".colorize(:blue)
        puts "***********".colorize(:blue)
        paint_hangman(0)
        puts
        puts "Press enter to start."
      end

    end

    def start_round(tries)
      if @language==SPANISH
        puts "¡JUGEMOS!".colorize(:green)
        puts "Intenta adivinar mi palabra secreta."
        puts "Sólo puedes fallar #{tries} veces."
      else
        puts "LET'S PLAY!".colorize(:green)
        puts "Try to guess my secret word."
        puts "You can only miss #{tries} times."
      end
      puts
      paint_hangman(tries)
    end

    def complain (complaint)
      puts complaint.colorize(:yellow)
    end

    def ok_message(message)
      puts message.colorize(:green)
    end

    def error_message(message)
      puts message.colorize(:red)
    end

    def ask_for_letter
      if @language==SPANISH
        puts "¿Cuál es tu próxima letra" 
        puts "(También puedes escribir 'save', 'load' or 'break' para grabar, cargar o salir del juego, respectivamente)."
      else
        puts "What is your next letter?" 
        puts "(You can also type 'save', 'load' or 'break' the game)."
      end
    end

    def victory
      if @language==SPANISH
        puts "¡Adivinaste la palabra secreta!"
        puts "¡¡HAS GANADO!!".colorize(:green)
      else
        puts "You guessed the secret word!"
        puts "YOU WIN!!".colorize(:green)
      end
      puts
    end

    def lose(word)      
      if @language==SPANISH
        puts "¡AHORCADO!".colorize(:red)
        puts "¡No te quedan más intentos!"
        print "La palabra secreta era: "
      else
        puts "HANGED!".colorize(:red)
        puts "You have no tries left!"
        print "The secret word was: "
     end
      puts word.colorize(:blue)
      puts
    end

    def ask_for_another_round
      if @language==SPANISH
        puts "¿Quieres jugar otra ronda (y=sí/n=no)?"
      else
        puts "Do you want to play another round (y/n)?"
      end
      
    end

    def ask_for_language
      puts "Do you want to play in English or in Spanish?"
      puts "¿Quiéres jugar en inglés o en español?"
      puts "E = English/inglés"
      puts "S = Spanish/español"
      puts "E/S?"
    end

    def goodbye
      if @language==SPANISH
        puts "¡GRACIAS POR JUGAR!"
      else
        puts "THANKS FOR PLAYING!"
      end
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
      if @language==SPANISH
        print "Intentos restantes: "
      else
        print "Tries left: "
      end
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