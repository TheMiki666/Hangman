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