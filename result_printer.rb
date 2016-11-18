# encoding: utf-8
require_relative 'game.rb'

class ResultPrinter

  def initialize
    @status_image = []

    (0..Game::MAXIMUM_ERRORS).each { |frame|
      file_name = __dir__ + "/image/#{frame}.txt"
      begin
        File.open(file_name, "r:UTF-8") { |f| @status_image << f.read }
      rescue Errno::ENOENT
        @status_image << "#{frame}"
      end
    }
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end

  def print_status(game)
    cls
    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "\nОшибки: #{game.bad_letters.join(', ')}"

    print_viselitsa(game.errors)

    if game.status == :lost
      puts "\nВы проиграли :(\n"
      puts "Загаданное слово было: #{game.letters.join}"
      puts
    elsif game.status == :won
      puts "Поздравляем, вы выиграли!\n\n"
    else
      puts "У вас осталось ошибок: #{Game::MAXIMUM_ERRORS - game.errors}"
    end
  end

  def get_word_for_print(letters, good_letters)
    letters.reduce('') { |result, item|
      good_letters.include?(item) ? result + item + ' ' : result + '__ '
    }
  end

  def cls
    system('clear') || system('cls')
  end
end
