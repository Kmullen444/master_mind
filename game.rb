class Game
  attr_reader :code
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

  def correct_peg (player_guess)
    count = 0
    code.each_with_index do |color1, idx1|
      player_guess.each_with_index do |color2, idx2|
        count += 1 if color1 == color2 && idx1 == idx2
      end
    end
    count
  end

  # TODO: Needs to only count pegs from guess if the peg is included but
  # isn't a perfect matach

  def correct_color (player_guess)
     count = 0
    code.each_with_index do |color1, idx1|
      player_guess.each_with_index do |color2, idx2|
        count += 1 if code.include?(color2) && color1 != color2
      end
    end
    count

  end
end
