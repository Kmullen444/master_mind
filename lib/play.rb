require_relative "game.rb"

game = Game.new

puts "Welcome to Master Mind, a fun game where you try an guess the code"
sleep 2
system('clear')
puts "You have 12 turns to guess!"
sleep 2
system('clear')

until game.win? || game.lose?
  game.turn
end

system('clear')

puts game.game_over
