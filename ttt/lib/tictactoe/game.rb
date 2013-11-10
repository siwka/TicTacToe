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
	end
end
