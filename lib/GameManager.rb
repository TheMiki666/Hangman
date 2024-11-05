module Hangman
  class GameManager
    require_relative 'Dictionary'
    require_relative 'ScreenManager'
    require_relative 'AlphabetManager'

    # Loop game status constant
    KEEP_PLAYING=0
    WIN=1
    LOSE=2
    BREAK=3

    def initialize
      @dic=Hangman::Dictionary.new
      @am=Hangman::AlphabetManager.new
      @sm=Hangman::ScreenManager.new
      @dic.start
    end
    
    def start_game
      @sm.greet
      gets.chomp
      loop do
        status=new_round
        break if status==BREAK || !another_round?
      end
      end_game
    end

    private

    def new_round
      @am.reset
      @am.set_secret_word(@dic.get_random_word)
      @sm.start_round(@am.tries_left)
      show_info()
      status=game_loop
      case status
      when WIN
        @sm.victory
      when LOSE
        @sm.lose
      end
      status
    end
    
    def another_round?
      answer=""
      loop do
        @sm.ask_for_another_round
        answer=gets.chomp.downcase
        answer="y" if answer=="yes"
        answer="n" if answer=="no"
        break if answer=="y" || answer=="n"
      end
      answer=="y"
    end

    def end_game
      @sm.goodbye
    end

    def game_loop
      status=KEEP_PLAYING
      loop do
        @sm.ask_for_letter
        char=gets.chomp.downcase
        if char=='break'
          status=BREAK
          break
        end
        char=char[0] if char.length >1
        if !@am.is_in_alphabet?(char)
          @sm.complain("That's not a valid character!")
        elsif @am.already_tried?(char)
          @sm.complain("That letter has been tried already.")
        else
          @am.try_character(char)
          @sm.paint_hangman(@am.tries_left)
          show_info
        end
        status=WIN if @am.secret_word_guessed?
        status=LOSE if @am.tries_left==0
        break if status!=KEEP_PLAYING
      end
      status
    end

    def show_info(char="")
      @sm.present_info(@am.guessed_word, @am.get_guessed_chars, @am.get_failed_chars, @am.tries_left, char)
    end
    
  end
end