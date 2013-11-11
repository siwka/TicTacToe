# require_relative 'console'
# require_relative 'game'

class Board
  attr_accessor :board, :human_player_symbol, :comp_player_symbol

  def initialize(human_player_symbol)
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @human_player_symbol = human_player_symbol
    @comp_player_symbol = (human_player_symbol == 'x') ? 'o' : 'x'
  end

  def board_dimention
    3
  end

end
