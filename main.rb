#encoding: UTF-8

require 'colorize'
require 'colorized_string'
require_relative 'lib/console_interface'
require_relative 'lib/game'

if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

puts 'Добро пожаловать в игру "Виселица"'

word = File.readlines(__dir__ + '/data/words.txt', encoding: 'UTF-8', chomp: true).sample

game = Game.new(word)
console = ConsoleInterface.new game

until game.over?
  console.print_out
  letter = console.get_input
  game.play!(letter)
end

console.print_out
