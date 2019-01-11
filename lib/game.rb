class Game
  attr_reader :letters, :good_letters, :bad_letters, :status, :errors

  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(word)
    word.downcase.split('')
  end

  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ''
    letter = STDIN.gets.downcase.chomp while letter == ''
    next_step(letter)
  end

  def is_good?(letter)
    @letters.include?(letter) ||
      (letter == 'е' && @letters.include?('ё')) ||
      (letter == 'ё' && @letters.include?('е')) ||
      (letter == 'и' && @letters.include?('й')) ||
      (letter == 'й' && @letters.include?('и'))
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
    when 'ё' then letters << 'е'
    when 'е' then letters << 'ё'
    when 'и' then letters << 'й'
    when 'й' then letters << 'и'
    else
      return
    end
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def lost?
    @errors >= 7
  end

  def next_step(letter)
    return if @status == -1 || @status == 1
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)
      @status = 1 if solved?
    else
      add_letter_to(@bad_letters, letter)
      @errors += 1
      @status = -1 if lost?
    end
  end

end