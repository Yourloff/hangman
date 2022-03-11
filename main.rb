require_relative 'lib/console_interface'
require_relative 'lib/game'

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
