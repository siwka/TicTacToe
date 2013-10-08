#!/usr/bin/env ruby

# Tic Tac Toe - algorythm use heuristic function
# removed recursion,
# created to optimize & sinplify code,
# goal was to make it unbeatable,
# Katarzyna Siwek

# methods draw boards for Tic Tac Toe
# they are more complicated because indexes in array reflect numeric pad
def draw_empty_board
# size of board 3x3 => n=3
	n = 3
	temp = [2,1,0]
	ind_board = []
	temp.each do |i|
		3.times do |j|
			ind_board << j+n*i+1
		end
	end

	puts "\n"
	ind_board.each do |i|
		print " "+ (i).to_s + " "
		if ((i) % n != 0)
			print "|"
		elsif ((i) != n)
			print "\n---+---+---\n"
		else
			print "\n"
		end	
	end
	puts "\n"
end # def draw_empty_board(board)


def draw_board(board)
# size of board 3x3  => n=3
	n = 3
	puts "\n"
	9.times do |ind|
		if (ind <n)
			print " " + board[ind+2*n].to_s + " "			
		elsif (2*n-1<ind)
			print " " + board[ind-2*n].to_s + " "
		else
			print " " + board[ind].to_s + " "
		end
		if ((ind+1) % n != 0)
			print "|"
		elsif ((ind+1) != n*n)
			print "\n---+---+---\n"
		else
			print "\n"
		end	
	end
	puts "\n"
end # def draw_board(board)


def input_players()
# let human_player chose symbol she/he will use
	puts "Choose 'o' or 'x':"
	begin
		system("stty raw -echo")
		human_player = STDIN.getc
		system("stty -raw echo")
	end while ((human_player != 'x') and (human_player != 'o'))

	# assign symbol to computer_player
	if human_player == 'x'
		computer_player = 'o'
	else
		computer_player = 'x'
	end
	puts "\nYou play as: '#{human_player}'\n_________________"

	# chose who is starting a game
	puts "\nDo you want to start a game (y/n)?"
	begin
		system("stty raw -echo")
		start_player = STDIN.getc
		system("stty -raw echo")
	end while ((start_player != 'y') and (start_player != 'n'))	

	if start_player == 'y'
		start_player = human_player
		puts "\nYou are starting a game."
	else
		start_player = computer_player
		puts "\nComputer is starting a game, chosing first move:\n"
	end

	return [human_player, computer_player, start_player]
end # input_players()


# method returns true if any current_player wons
def won (board, current_player)
# variable test becomes true if current_player has marked
# 3 characters in row, column or diaginally
# moew code, less operations? :-)

	test = false
	if (board[4] == current_player)
		if ((board[1] == current_player) && (board[7] == current_player))
			test = true
		elsif ((board[2] == current_player) && (board[6] == current_player))
			test = true
		elsif ((board[3] == current_player) && (board[5] == current_player))
			test = true
		elsif ((board[0] == current_player) && (board[8] == current_player))
			test = true	
		end
	end
	if (board[0] == current_player)
		if ((board[1] == current_player) && (board[2] == current_player))
			test = true
		elsif ((board[3] == current_player) && (board[6] == current_player))
			test = true
		end
	end	
	if (board[8] == current_player)
		if ((board[2] == current_player) && (board[5] == current_player))
			test = true		
		elsif ((board[6] == current_player) && (board[7] == current_player))
			test = true
		end	
	end

	return test
end # def won(board, current_player)


def tie (board) 
# tie if there is no more moves, meaning no space in array
# to simplyfy we assume that won() was called before tie()
	board.each {|ele|
		if (ele == " ")
			return false
		end
	}
	return true
end # def tie (board)


def heuristc_val(board)
	# *** Since our priority is not to let human win (not to win)
	# *** I changed heurestic function to 3a+b-(4c+d)
	# estimate value for each node of a game as 3*a+b-(3*c+d)
	# by analyzing each line: horizontal, vertical and diagonal
	# variableds a, b, c, d stands for number of lines meeting following criteria:
	# a: 2 computer player char, 0 human player char in line
	# b: 1 computer player char, 0 human player char in line
	# c: 0 computer player char, 2 human player char in line
	# d: 0 computer player char, 1 human player char in line

	temp = [
		# horizontal lines
		board[0..2],
		board[3..5],
		board[6..8],

		# # vertical lines
		board.values_at(0,3,6),
		board.values_at(1,4,7),
		board.values_at(2,5,8),

		# diagonal lines
		board.values_at(0,4,8),
		board.values_at(2,4,6)
		]

	temp_comp = temp.map {|ele| ele.count{|i| i == $computer_player}}
	temp_humn = temp.map {|ele| ele.count{|i| i == $human_player}}
	temp_result = temp_comp.zip(temp_humn)

	a = temp_result.count{|i| i == [2,0]}
	b = temp_result.count{|i| i == [1,0]}
	c = temp_result.count{|i| i == [0,2]}
	d = temp_result.count{|i| i == [0,1]}

	return [3*a+b-(4*c+d), 4*c+d]
end #heuristc_val(board)


def estimate_moves(board, current_player)
	# collect eva;uated results for each move
	considered_mv = []
	considered_hu = []

	# analyse each next possible move:
	9.times do |ind|
		if board[ind] == " "
			board[ind] = current_player
			score = heuristc_val(board)
			board[ind] = " " # clear selection
			considered_mv << score[0]
			considered_hu << score[1]
		else
			considered_mv << -FIXNUM_MAX # min system int, not to rewrite taken space (move)
			considered_hu << -FIXNUM_MAX 
		end
	end
	
	return [considered_mv, considered_hu]
end # estimate_moves(board, current_player)


def selected_from_best_comp_mv(results)
# find indexes of all maximums and chose random one
	max_val = results.max
	indexes = []
	maxes = []

	results.each_with_index do |ele, indx|
		temp = []
		temp << ele
		temp << indx
		indexes << temp
	end

	indexes.each do |ele| 
		if ele[0] == max_val
			maxes << ele
		end
	end

	return maxes
end # def selected_from_best_comp_mv(results)


def remove_mv(considered_hu, max_moves)
# removes from possible good moves the one with biggest potential to lose
	human_max_score = -FIXNUM_MAX
	rm_mv = -1 # add error handling? since no -1 position to del
	max_moves.length.times do |ind|
		if considered_hu[max_moves[ind][1]] > human_max_score
			human_max_score = considered_hu[max_moves[ind][1]]
			rm_mv = max_moves[ind][1]
		end
	end
	return rm_mv
end # remove_mv(considered_hu, max_moves)


def computer_move(board)
# find next computer move

	#win_inds = []
	9.times do |ind|
		if board[ind] == " "
			board[ind] = $computer_player
			if won(board, $computer_player)
				return ind
			end
			board[ind] = " "
			#win_inds << ind			
		end
	end
	# if win_inds != []
	# 	return win_inds.sample
	# end

	# start with a special case to avoid human signes in 3 corners in 2 empty lines
	if board.count(" ") == 6 && board[4] == $computer_player &&
	  ((board[0] == $human_player && board[8] == $human_player) ||
	  (board[2] == $human_player && board[6] == $human_player))
		arr_mv = [1,3,5,7]
		mv = arr_mv.sample
	else
		considered_temp = estimate_moves(board, $computer_player)
		considered_mv = considered_temp[0]
		considered_hu = considered_temp[1]
		max_moves = selected_from_best_comp_mv(considered_mv)

		# mirror and turned board are the same game cases
		# here we consider only it this is middle board, corner or middle side
		# as 1st, 2nd, and 3rd best choice respectevely
		
		# one only the best move for computer
		if max_moves.length == 1
			mv = max_moves[0][1]
		else
			# remove the best chance for human
			max_moves.delete([max_moves[0][0], remove_mv(considered_hu, max_moves)])
			# randome choice
			result = max_moves.sample
			mv = result[1]
		end
	end
		
	puts "Computer choose move to #{mv+1}"
	return mv
end # def computer_move (board)


def human_move(board)
	print "\nPerson is choosing a move:\nChoose your move (1-9) in an empty space: "
	
	begin
		system("stty raw -echo") # wczytaj dane od uzytkownika
		mv = STDIN.getc
		system("stty -raw echo")
	end until ["1","2","3","4","5","6","7","8","9"].index(mv) && (board[mv.to_i - 1] == " ")

	puts mv
	mv = mv.to_i
	mv = mv-1 # array numbered [0..8], board [1..9]
	return mv
end # def human_move(board)


def move(board, current_player)
	if (current_player == $human_player)
		mv = human_move(board)
	else
		mv = computer_move(board)
	end

	board[mv] = current_player
	draw_board(board)
end # def move(board, current_player)


def continue_game?
	puts "Play again? (y/n):"	
	begin
		system("stty raw -echo")
		response = STDIN.getc
		system("stty -raw echo")
	end until response == 'y' || response == 'n'

	return response == 'y' ? false : true
end # def continue_game?


def switch_player(current_player)
	if (current_player == $human_player)
		current_player = $computer_player
	else
		current_player = $human_player
	end

	return current_player
end # def switch_player(current_player)


# # # # # # ################################################### # # # # # #
begin
# clear screen
puts "\e[H\e[2J"

FIXNUM_MAX = (2**(0.size * 8 -2))
# reseat board = board.new(9) spr
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

# set who starts a game & which symbol use
input_symbols = input_players()
$human_player = input_symbols[0]
$computer_player = input_symbols[1]  # spr czy da sie skrocic do 1 linii
current_player = input_symbols[2]

draw_empty_board
puts "\nUse numeric pad that mimic above board to play\n"

# game:
while (!won(board, $human_player) && (!won(board, $computer_player)) && (!tie(board)))
	move(board, current_player)
	current_player = switch_player(current_player)
end

# end of a game
if !tie(board)
	current_player = switch_player(current_player)
	puts "\nPlayer '#{current_player}' won!\n"
else
	puts "Game is over - draw!"
end
puts "\n===================================================="
puts
end until continue_game?