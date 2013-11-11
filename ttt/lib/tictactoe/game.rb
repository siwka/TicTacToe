# require_relative 'board'
# require_relative 'console'

module TicTacToe
	class Game
		attr_accessor :current_player

		def initialize(output)
			@output = output
			@console = Console.new
			@current_player = 'x'
		end

		def start
			@output.puts "Welcome to tic tac toe!\n"
			@output.puts "\nLet's set a game:\n"

		end

		def set_game
			@console.chose_symbol?
			@game_board = Board.new(@console.human_symbol) #ks ???? check @ too here or in def line
			@output.puts "You use '#{@game_board.human_player_symbol}'"
			@output.puts "Computer uses '" + @game_board.comp_player_symbol + "'"
			@output.puts "\nUse numeric pad that mimic a board to play\n"
			@console.draw_empty_board(@game_board.board_dimention)			
			@console.who_starts?
			@current_player = @console.human_starts? ? @game_board.human_player_symbol : @game_board.comp_player_symbol
		end

		def play
			while (!won?(board) && (!tie(board)))
				action.move(board, current_player)
				current_player = action.switch_player(current_player)
			end
		end

		def won?(board)
			#ks @game_board.board ?
			if player = won_horizontal?(board)
				return player
			end
			if player = won_vertical?(board)
				return player
			end
			if player = won_diagonal?(board)
				return player
			end	
			return false			
		end

		def won_horizontal?(board)
			b = board
			if [b[0..2].join, b[3..5].join, b[6..8].join].include?("xxx")
				return 1
			end
			if [b[0..2].join, b[3..5].join, b[6..8].join].include?("ooo")
				return 2
			end
			return false
		end

		def won_vertical?(board)
			b = board
			if [b[0]+b[3]+b[6], b[1]+b[4]+b[7], b[2]+b[5]+b[8]].include?("xxx")
				return 1
			end
			if [b[0]+b[3]+b[6], b[1]+b[4]+b[7], b[2]+b[5]+b[8]].include?("ooo")
				return 2
			end	
			return false
		end

		def won_diagonal?(board)
			b = board
			if [b[0]+b[4]+b[8], b[2]+b[4]+b[6]].include?("xxx")
				return 1
			end	
			if [b[0]+b[4]+b[8], b[2]+b[4]+b[6]].include?("ooo")
				return 2
			end
			return false	
		end

		def tie?(board)
		# tie if there is no more moves, meaning no space in array
		# to simplyfy we assume that won() was called before tie()
			return board.none? { |b| b == " " }
		end

	end
end
