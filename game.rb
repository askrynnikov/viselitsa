require 'unicode_utils'
# encoding: utf-8

class Game
  MAXIMUM_ERRORS = 7

  attr_reader :errors, :letters, :good_letters, :bad_letters, :status

  def initialize(word)
    @letters = convert_string(get_letters(word).join).split(//)
    @good_letters, @bad_letters = [], []
    @errors, @status = 0, :runs
  end

  def next_step(letter)
    if @status == :runs &&
      !@good_letters.include?(letter) &&
      !@bad_letters.include?(letter)

      if @letters.include? letter
        @good_letters << letter
        @status = :won if @good_letters.uniq.sort == @letters.uniq.sort
      else
        @bad_letters << letter
        @errors += 1
        @status = :lost if @errors >= MAXIMUM_ERRORS
      end
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ''
    while letter == ''
      letter = STDIN.gets.encode('UTF-8').chomp
    end

    next_step(convert_string(letter))
  end

  private

  def get_letters(word)
    abort 'Задано пустое слово, игра не состоится.' if word == nil || word == ''
    word.encode('UTF-8').split(//)
  end

  def convert_string(string)
    UnicodeUtils.downcase(string).tr('ё', 'е').tr('й', 'и')
  end
end
