require_relative "./player.rb"

class Game
  attr_reader :code, :COLORS
  @@COLORS = [:R,:O,:Y,:G,:B,:I]

  def self.create_code 
    @code = []
    4.times { @code << @@COLORS[rand(@@COLORS.length)] }
    @code
  end

  def initialize(players = 1)
    @players = []
    @code    = Game.create_code 
    @turns   = 12
    
    players.times { @players << Player.new } 
  end
  
  def player_guess
    @player_guess = current_player.get_move
  end


  def current_player
    current_player = @players.last if current_player = @players.first
  end

  def exact_match(guess)
    count = 0
    code.each_with_index do |color1, idx1|
      guess.each_with_index do |color2, idx2|
       count += 1 if color1 == color2 && idx1 == idx2 
      end
    end   
   count
  end

  def match_remover(code_to_check, main_code)
    code_to_check.select.with_index do |color, i|
      color if code_to_check[i] != main_code[i]
    end
  end

  def color_match(guess)
    no_match_code = match_remover(code, guess)
    no_match_player = match_remover(guess, code)
    no_match_player.count { |color| no_match_code.include?(color) }
  end 

  def lose?
    @turns == 0
  end

  def win?
    @player_guess == code
  end

  def game_over
    if lose?
      "Looks like the computer got you this time! The code was #{code}"
    else
      "You win!"
    end
  end

  def return_results(color_match, peg_match)
    "Matched Pegs: #{peg_match} and Color Matched: #{color_match}. You have #{@turns} left"
  end

  def turn
    turn_guess = current_player.get_move
    
    until valid?(turn_guess)
      puts "That's not a valid guess. Please try again"
      turn_guess = current_player.get_move
    end
  
    turn_exact_match = exact_match(turn_guess)
    turn_color_match = color_match(turn_guess)
    @turns -= 1
    puts return_results(turn_color_match, turn_exact_match)
  end
  
  def valid?(guess)
    guess.length == 4 &&
        guess.all? { |color| @@COLORS.include?(color) }
  end
end
