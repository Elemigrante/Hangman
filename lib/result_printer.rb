class ResultPrinter
  def initialize(game)
    @status_image = []
    counter = 0

    while counter <= game.max_errors
      file_name = "#{__dir__}/../image/#{counter}.txt"

      begin
        file = File.new(file_name, 'r:UTF-8')
        @status_image << file.read
        file.close
      rescue SystemCallError # Если изображения нет
        # продолжаем работу
        @status_image << "\n[ Изображение не найдено ]\n"
      end
      counter += 1
    end
  end

  def print_hangman(errors)
    puts @status_image[errors]
  end

  def print_status(game)
    cls
    puts game.version

    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки (#{game.errors}): #{game.bad_letters.join(', ')}"

    print_hangman(game.errors)

    if game.lost?
      puts 'Вы проиграли'
      puts
      puts "Загаданное слово: #{game.letters.join('')}"
      puts
    elsif game.won?
      puts "Поздравляем! Вы выиграли!\n\n"
    else
      puts "У вас осталось попыток: #{game.errors_left}"
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ''

    for item in letters do
      if good_letters.include?(item)
        result += item + ' '
      else
        result += '__ '
      end
    end
    result
  end

  def cls
    system('clear') || system('cls')
  end
end
