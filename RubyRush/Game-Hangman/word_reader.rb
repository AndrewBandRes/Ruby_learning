# frozen_string_literal: true

#
# Class WordReader for reading hidden word for game
class WordReader
  def read_from_args
    ARGV[0]
  end

  def read_from_file(file_name)
    file = File.new(file_name)
    lines = file.readlines
    file.close

    lines.sample.chomp
  end
end
