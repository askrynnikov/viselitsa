# encoding: utf-8

class WordReader
  def read_from_args
    ARGV[0]
  end

  def read_from_file(file_name)
    begin
      File.readlines(file_name).sample.chomp
    rescue Errno::ENOENT => e
      puts e.message
      puts e.backtrace
      abort "Не найден файл со словами-загадками: #{file_name}"
    end
  end
end
