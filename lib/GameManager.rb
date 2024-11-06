module Hangman
  class GameManager
    require 'json'
    require_relative 'Dictionary'
    require_relative 'ScreenManager'
    require_relative 'AlphabetManager'
    require_relative 'AlphabetManager/Alphabet'

    # Loop game status constant
    KEEP_PLAYING=0
    WIN=1
    LOSE=2
    BREAK=3
    SAVE_PATH="data/save.json"

    def initialize
      @sm=Hangman::ScreenManager.new
      @dic=Hangman::Dictionary.new
      @am=Hangman::AlphabetManager.new
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

    def save_game
      alpha=@am.export_alphabet
      serial=to_json(alpha)
      begin
        file=File.open(SAVE_PATH, 'w')
        file.write(serial)
        file.close
        @sm.ok_message("Game saved sucessfully.")
      rescue
        @sm.error_message("Impossible to save the game!")
        @sm.complain("Check write permissions of your Operative System.")
      end
    end

    def to_json(alpha)
      JSON.dump({
        :alphabet => alpha.alphabet,
        :flags => alpha.flags,
        :secret_word => alpha.secret_word,
        :tries_left => alpha.tries_left 
      })
    end

    def load_game
      begin
        file=File.open(SAVE_PATH, 'r')
        serial=file.read
        file.close
        alpha=from_json(serial)
        @am.import_alphabet(alpha)
        @sm.ok_message "Game loaded correctly."
        @sm.paint_hangman(@am.tries_left)
        show_info
      rescue
        @sm.error_message "Game not loaded!"
        @sm.complain "Check if a saved game exists"
      end
    end

    def from_json(serial)
      data=JSON.load(serial)
      alpha=Hangman::Alphabet.new(data['secret_word'],data['tries_left'],data['alphabet'],data['flags'])
      alpha
    end

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
        @sm.lose(@am.secret_word)
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
        if char=='save'
          save_game
        elsif char=='load'
          load_game
        else
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