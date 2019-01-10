require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'

puts "Игра 'Виселица'. Вер.2.\n\n"
sleep 1

printer = ResultPrinter.new

begin
reader = WordReader.new
word_current_path = "#{__dir__}/data/words.txt"
word = reader.read_from_file(word_current_path)
rescue SystemCallError
  abort 'Файл со словами не найден!'
end

game = Game.new(word)

while game.status.zero?
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)