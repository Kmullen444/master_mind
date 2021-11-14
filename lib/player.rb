class Player
  def get_move
    puts "Please enter a guess using 'ROYGBI'in the order of your guess"
    player_guess = gets.chomp
    player_guess.split('').map { |color| color.upcase.to_sym }
  end
end
