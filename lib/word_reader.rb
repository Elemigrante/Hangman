class WordReader
  def read_from_file(file_name)
    lines = File.readlines(file_name)
    lines.sample.chomp
  end
end

