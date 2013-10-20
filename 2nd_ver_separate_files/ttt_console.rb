def clear_screen
	puts "\e[H\e[2J"
end


def introducation
	puts "\nUse numeric pad that mimic above board to play\n"
end


def draw_empty_board
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


def get_char
	system("stty raw -echo")
	mv = STDIN.getc
	system("stty -raw echo")
	return mv
end


def chose_o_or_x
	puts "Choose 'o' or 'x':"
end


def info_human_symbol(human_player)
	puts "\nYou play as: '#{human_player}'\n_________________"
end


def ask_start_player
	puts "\nDo you want to start a game (y/n)?"
end


def info_human_start
	puts "\nYou are starting a game."
end


def info_computer_start
	puts "\nComputer is starting a game, chosing first move:\n"
end


def read_human_move
	print "\nPerson is choosing a move:\nChoose your move (1-9) in an empty space: "
	
	begin
		mv = get_char
	end until ["1","2","3","4","5","6","7","8","9"].index(mv)

	puts mv
	mv = mv.to_i
	mv = mv-1
	return mv
end


def ask_if_continue_game
	puts "Play again? (y/n):"	
	begin
		system("stty raw -echo")
		response = STDIN.getc
		system("stty -raw echo")
	end until response == 'y' || response == 'n'
	return response
end


def print_computer_move(mv)
	puts "Computer choose move to #{mv+1}"
end


def win_info(current_player)
	puts "\nPlayer '#{current_player}' won!\n"
end


def draw_info
	puts "Game is over - draw!"
end


def draw_beautiful_line
	puts "\n===================================================="
	puts
end