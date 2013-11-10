module TicTacToe
	class Game
		def initialize(output)
			@output = output
		end

		def start
			@output.puts 'Welcome to tic tac toe!'
			@output.puts 'Who is going to make first move: 1-you, 2-computer?:'
			@output.puts 'Choose o or x:'
		end

		def set_game(human_input_symbol)
			game_board = Board.new(human_input_symbol) #check @ too here or in def line
			@output.puts "You use '#{game_board.human_player_mark}'"
			@output.puts "Computer uses '" + game_board.comp_player_mark + "'"
			#draw empty board
		end

		# def human_move(input_symbol)
		# 	@input_symbol = input_symbol
		# end
	end
end
