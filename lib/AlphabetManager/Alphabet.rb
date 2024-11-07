# This object contains the attributes of the AlphabetManager object 
# (except the atrribute guessed_word, that can be deduced)
# It has no methods, only attributes
# It is used to be serialized and stored in a file

module Hangman
  class Alphabet
    attr_reader :secret_word, :tries_left, :alphabet, :flags
    
    def initialize(secret_word, tries_left, alphabet, flags)
      @secret_word=secret_word
      @tries_left=tries_left
      @alphabet=alphabet
      @flags=flags
    end
  end
end