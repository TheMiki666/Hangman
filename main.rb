require_relative 'lib/Dictionary'
require_relative 'lib/ScreenManager'

dic=Hangman::Dictionary.new
dic.start

10.times {puts dic.get_random_word}

sm=Hangman::ScreenManager.new
(0..10).each do |i|
  sm.paint_hangman(i)
end