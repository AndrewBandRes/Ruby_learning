# encoding: utf-8
#
# Class WordReader for reading hidden word for game
class WordReader
  def read_from_args
    return ARGV[0]
  end

  def read_from_file(file_name)
    
    file = File.new(file_name, "r:UTF-8")
    lines = file.readlines
    file.close
    
    lines.sample.chomp
  end
end
