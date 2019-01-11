class Game
  attr_reader :letters, :good_letters, :bad_letters, :status, :errors
  MAX_ERRORS = 7

  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = :in_progress # :won, :lost
  end

  def get_letters(word)
    word.downcase.split('')
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
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
    @status == :lost || @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def next_step(letter)
    return if @status == :lost || @status == :won
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)
      @status = :won if solved?
    else
      add_letter_to(@bad_letters, letter)
      @errors += 1
      @status = :lost if lost?
    end
  end

end