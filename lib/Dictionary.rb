module Hangman
  class Dictionary
    require 'colorize'
    ENGLISH=0 #default language
    SPANISH=1
    ENGLISH_FILE='data/english_words.txt'
    SPANISH_FILE='data/spanish_words.txt'

    def initialize (language)
      @min_letters = 5
      @max_letters = 12
      @language=language
      if language==SPANISH
        @data_file=SPANISH_FILE
      else
        @data_file=ENGLISH_FILE
      end
    end

    def start
      load_words
    end

    def get_random_word
      word=@words.sample
      if @language=SPANISH
        word=spanish_filter(word)
      end
      word
    end

    private

    def spanish_filter(word)
      (0..word.length-1).each do |i|
        case word[i]
        when 'á'
          word[i]='a'
        when 'é'
          word[i]='e'
        when 'í'
          word[i]='i'
        when 'ó'
          word[i]='o'
        when 'ú'
          word[i]='u' 
        when 'ü'
          word[i]='u'           
        end
      end
      word
    end

    def load_words
      @words = []
      begin
        file=File.open(@data_file, 'r')
        while !file.eof? do
          word=file.gets.chomp.downcase
          if word.length <= @max_letters && word.length >= @min_letters
            @words.push(word)
          end
        end
        @words.uniq!
        file.close
        puts "Dictionary loaded correctly".colorize(:green)
      rescue 
        puts "LOAD ERROR".colorize(:red)
        puts "It has been impossible read file #{data_file}"
        puts "We have to use the emergency dictionary (with less words)"
        load_emergency_words
      end
      
    end

    def load_emergency_words
      @words=["community", "civilization", "awareness", "trooper", "centaur", "perforation", "reticent", "mortgage"]
    end

  end

end