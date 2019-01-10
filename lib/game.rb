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

  def next_step(letter)
    if @status == -1 || @status == 1
    end

    if @good_letters.include?(letter) || @bad_letters.include?(letter)
    end

    if @letters.include?(letter) ||
        (letter == 'е' && @letters.include?('ё')) ||
        (letter == 'ё' && @letters.include?('е')) ||
        (letter == 'и' && @letters.include?('й')) ||
        (letter == 'й' && @letters.include?('и'))

      @good_letters << letter
      @good_letters << 'ё' if letter == 'е'
      @good_letters << 'е' if letter == 'ё'
      @good_letters << 'и' if letter == 'й'
      @good_letters << 'й' if letter == 'и'
      
      @status = 1 if (@letters - @good_letters).empty?
    else
      @bad_letters << letter
      @errors += 1
      @status = -1 if @errors >= 7
    end
  end
end