class ResultPrinter
  def initialize
    @status_image = []

    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= 7
      file_name = current_path + "/image/#{counter}.txt"

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

  def print_viselitsa(errors)
    puts @status_image[errors]
  end

  def print_status(game)
    cls

    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки (#{game.errors}): #{game.bad_letters.join(', ')}"

    print_viselitsa(game.errors)

    if game.errors >= 7
      puts 'Вы проиграли'
      puts
      puts "Загаданное слово: #{game.letters.join('')}"
      puts
    elsif (game.letters - game.good_letters).empty?
      puts "Поздравляем! Вы выиграли!\n\n"
    else
      puts 'У вас осталось попыток: ' + (7 - game.errors).to_s
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