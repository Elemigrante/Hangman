require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'

VERSION = "Игра 'Виселица'. Версия 3. (c) Хороший программист\n\n"
sleep 1

reader = WordReader.new
word_current_path = "#{__dir__}/data/words.txt"

begin
  word = reader.read_from_file(word_current_path)
rescue SystemCallError
  puts 'Файл со словами не найден!'
  exit
end

game = Game.new(word)
game.version = VERSION

printer = ResultPrinter.new(game)

while game.in_progress?
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
