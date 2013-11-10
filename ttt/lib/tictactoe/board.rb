class Board
  attr_accessor :board, :human_player_mark, :comp_player_mark

  def initialize(human_player_mark)
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @human_player_mark = human_player_mark
    @comp_player_mark = (human_player_mark == 'x') ? 'o' : 'x'
  end

end
