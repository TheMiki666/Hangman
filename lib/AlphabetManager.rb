module Hangman
  class AlphabetManager
      # Flags for the array @flags
      NOT_USED = 0
      IN_SECRET_WORD = 1
      NOT_IN_SECRET_WORD = 2

      #Max number of tries
      MAX_TRIES=10

      attr_reader :tries_left, :secret_word, :guessed_word

      def initialize
          @alphabet=[]
          @flags=[]
          ('a'..'z').each do |char|
            @alphabet.push(char)
            @flags.push(NOT_USED)
          end
          reset
      end

      def reset
          @secret_word=""
          @guessed_word=""
          @flags.map!{|flag| flag=NOT_USED}
          @tries_left=MAX_TRIES

      end

      def set_secret_word(word)
          @secret_word=word.downcase
          @guessed_word=""
          word.length.times{ @guessed_word.concat("_")}
      end

      def add_letter(char)
          if char.length == 1 && !@alphabet.include?(char)
               @alphabet.push(char.downcase)
               @flags.push(NOT_USED)
          end
      end

      def is_in_alphabet?(char)
          @alphabet.include?(char.downcase)
      end

      def already_tried?(char)
          # If the caracter is not valid, we return true, to avoid trying this caracter
          return true if char.length !=1 || !is_in_alphabet?(char)

          char=char.downcase
          @flags[@alphabet.find_index(char)]!=NOT_USED
      end

      def try_character(char)
          char=char.downcase
          return false if already_tried?(char)

          if @secret_word.include?(char)
              @flags[@alphabet.find_index(char)]=IN_SECRET_WORD
              (0..@secret_word.length).each do |i|
                  #Revealing the character in the guessed word
                  @guessed_word[i]=char if @secret_word[i]==char
              end
              true
          else
              @flags[@alphabet.find_index(char)]=NOT_IN_SECRET_WORD
              @tries_left -= 1
              @tries_left = 0 if @tries_left<0
              false
          end
      end

      def secret_word_guessed?
         secret_word.length>0 && !@guessed_word.include?("_")
      end

      def get_guessed_chars
          string=""
          (0..@alphabet.length).each do |i|
              string.concat(@alphabet[i]) if @flags[i]==IN_SECRET_WORD
          end
          string
      end

      def get_failed_chars
          string=""
          (0..@alphabet.length).each do |i|
              string.concat(@alphabet[i]) if @flags[i]==NOT_IN_SECRET_WORD
          end
          string
      end

  end
end
