class Game
  attr_reader :code, :COLORS
  @@COLORS = [:R,:O,:Y,:G,:B,:I]

  def initialize(players = 1)
    @players = players
    @turns   = 12
  end

  def create_code 
    @code = []
    4.times { @code << @@COLORS[rand(@@COLORS.length)] }
    @code
  end

  def valid?(player_guess)
    player_guess.length == 4 &&
        player_guess.all? { |color| @@COLORS.include?(color) }
  end

  def exact_match(player_guess)
    count = 0
    code.each_with_index do |color1, idx1|
      player_guess.each_with_index do |color2, idx2|
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

  def color_match(player_guess)
    no_match_code = match_remover(code, player_guess)
    no_match_player = match_remover(player_guess, code)
    no_match_player.count { |color| no_match_code.include?(color) }
  end 

  def win?(player_guess)
    player_guess == code
  end

  # TODO: Make prompt for a with color_match and exact_match
  # Make a turn the will loop until win?
end
