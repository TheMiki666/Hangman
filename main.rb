require_relative 'lib/Dictionary'
require_relative 'lib/ScreenManager'
require_relative 'lib/AlphabetManager'

dic=Hangman::Dictionary.new
dic.start

am=Hangman::AlphabetManager.new
sm=Hangman::ScreenManager.new

am.set_secret_word(dic.get_random_word)

('a'..'z').each do |char|
  am.try_character(char)
  sm.paint_hangman(am.tries_left)
  sm.present_info(am.guessed_word, am.get_guessed_chars, am.get_failed_chars, am.tries_left, char)
  gets.chomp
end

