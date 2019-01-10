require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'

puts "Игра виселица. Версия 1.\n\n"
sleep 1

printer = ResultPrinter.new
reader = WordReader.new
# begin
#     SystemCallError puts 'Файл со словами не найден!'
# end

current_path = File.dirname(__FILE__)
word = reader.read_from_file(current_path + '/data/words.txt')

game = Game.new(word)

while game.status.zero?
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)