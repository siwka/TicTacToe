require_relative 'ttt_heuristic'
require_relative 'ttt_console'


begin
	clear_screen

	action = Action.new
	board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
	# set who starts a game & which symbol use
	input_symbols = action.input_players()
	$human_player = input_symbols[0]      
	$computer_player = input_symbols[1]
	current_player = input_symbols[2]

	draw_empty_board
	introduction

	# game:
	while (!action.won(board, $human_player) && (!action.won(board, $computer_player)) && (!action.tie(board)))
		action.move(board, current_player)
		current_player = action.switch_player(current_player)
	end

	# end of a game
	if !action.tie(board)
		current_player = action.switch_player(current_player)
		win_info(current_player)
	else
		draw_info
	end
	draw_beautiful_line
end until action.continue_game?   # while true  - use instead until // use break ?