# This class reads all the words writen in a file (depending on the language),
# filter them, keeps the filtered words in memory, and gives a word randomly
# If it's not possible to read that file, it charges on memory a few emergency words, in order to be able to test (or play) the game 
# When playing in Spanish, it removes the accents and umlaut of the vowels

module Hangman
  class Dictionary
    require 'colorize'
    ENGLISH=0 #default language
    SPANISH=1
    ENGLISH_FILE='data/english_words.txt'
    SPANISH_FILE='data/spanish_words.txt'

    def initialize (language=ENGLISH)
      @min_letters = 5
      @max_letters = 12
      @language=language
      if language==SPANISH
        @data_file=SPANISH_FILE
      else
        @data_file=ENGLISH_FILE
      end
    end

    # Makes the Dictionary load the words on memory
    def start
      load_words
    end

    # Gives a random word
    # The AphabetManager object have to call this method when needs a new secret word
    def get_random_word
      word=@words.sample
      if @language=SPANISH
        word=spanish_filter(word)
      end
      word
    end

    private

    # Removes the accents and umlaut of the vowels when playing in Spanish
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
        if @language==SPANISH
          puts "Diccionario cargado con éxito.".colorize(:green)
        else
          puts "Dictionary loaded sucessfully.".colorize(:green)
        end
      rescue 
        if @language==SPANISH
          puts "ERROR DE CARGA".colorize(:red)
          puts "Ha sido imposible leer el fichero #{@data_file}."
          puts "Tendremos que usar el diccionario de emergencia (con menos palabras)."
        else
          puts "LOAD ERROR".colorize(:red)
          puts "It has been impossible read file #{@data_file}"
          puts "We have to use the emergency dictionary (with less words)"
        end
        load_emergency_words
      end
      
    end

    def load_emergency_words
      if @language==SPANISH
        @words=["leñador", "primitivo", "cientifico", "caspa", "lagartija", "embarazo", "reaccion", "estulto"]
      else
        @words=["community", "civilization", "awareness", "trooper", "centaur", "perforation", "reticent", "mortgage"]
      end
      
    end

  end

end