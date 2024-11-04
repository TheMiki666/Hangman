module Hangman
  class Dictionary

    def initialize
      @english_file = 'data/english_words.txt'
      @min_letters = 5
      @max_letters = 12
    end

    def start
      load_words
    end

    def get_random_word
      @words.sample
    end

    private

    def load_words
      @words = []
      begin
        file=File.open(@english_file, 'r')
        while !file.eof? do
          word=file.gets.chomp.downcase
          if word.length <= @max_letters && word.length >= @min_letters
            @words.push(word)
          end
        end
        @words.uniq!
        file.close
        puts "Dictionary loaded correctly"
      rescue 
        puts "LOAD ERROR"
        puts "It has been impossible read file #{@english_file}"
        puts "We have to use the emergency dictionary (with less words)"
        load_emergency_words
      end
      
    end

    def load_emergency_words
      @words=["community", "civilization", "awareness", "trooper", "centaur", "perforation", "reticent", "mortgage"]
    end

  end

end