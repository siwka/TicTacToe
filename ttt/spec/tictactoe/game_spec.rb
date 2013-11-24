require 'spec_helper'

module TicTacToe
	describe Game do
		let(:output) { double('output').as_null_object }
		let(:game) { Game.new(output) }

		before do
			@arr_01 = [" ", " ", " ",
				  	     " ", " ", " ",
		 			       " ", " ", " "]
		
			@arr_02 = ["x", " ", "x",
				  			 " ", "o", " ",
				  			 " ", "o", " "]
		
			@arr_03 = ["x", " ", " ",
					  		 " ", "o", "o",
					  		 "x", " ", " "]			  
			
			@arr_04 = ["x", "o", "o",
					  		 " ", "x", "x",
					  		 "o", "o", " "]

			@arr_05 = ["x", " ", " ",
					  		 " ", "o", " ",		# special case
					  		 " ", " ", "x"]

			@arr_06 = [" ", "x", " ",   # one best move
					  		 " ", " ", "o",
					  		 " ", "o", "x"]


			@arr_07 = [" ", "x", " ",   # best move 6 lead to lose -> remove human best
					  		 " ", "o", "x",
					  		 " ", "o", " "]	
		end		

		describe "#start" do

			it 'sends a welcome message' do
				output.should_receive(:puts).with("Welcome to tic tac toe!\n")
				game.start
			end

			it "prints information to use numeric pad pattern" do
				output.should_receive(:puts).with("\nLet's start a game:\n")
				game.start
			end
		end

		describe "#play" do
			game_board = Board.new('x')

			before do
				@arr_08 = ["x", " ", " ",
					  	     " ", "x", " ",
			 			       " ", " ", "x"]
				@arr_09 = ["x", "x", "x",
					  	     " ", " ", " ",
			 			       " ", " ", "x"]
				@arr_10 = ["x", "x", "o",
					  	     " ", "x", " ",
			 			       "o", "x", "o"]			 			       			 			       
				@arr_11 = ["x", " ", "o",
					  	     " ", "x", "o",
			 			       " ", " ", "o"]
				@arr_12 = ["x", "x", "o",
					  	     " ", "o", " ",
			 			       "o", " ", "x"]			 			       
				@arr_13 = ["x", "x", " ",
					  	     "x", "o", "x",
			 			       "o", "x", "x"]			 	
				@arr_14 = [" ", " ", "o",
					  	     " ", "x", " ",
			 			       "o", " ", "x"]
				@arr_15 = [" ", "x", "x",
					  	     "o", "o", "o",
			 			       "o", " ", "x"]				 			       
		 	end

		 	it "returns false if no horizontal win" do
		 		game.game_board = game_board
		 		game.won_horizontal?(@arr_08).should be_false
		  end
		 	it "returns x upon x-player win" do
		 		game.game_board = game_board
		 		game.won_horizontal?(@arr_09).should eql 'x'
		  end
		 	it "returns x if x-player won" do
		 		game.game_board = game_board
		 		game.won?(@arr_10).should eql 'x'
		  end
		 	it "returns o if o-player won" do
		 		game.game_board = game_board
		 		game.won?(@arr_11).should eql 'o'
		  end	
		 	it "returns o if o-player won" do
		 		game.game_board = game_board
		 		game.won?(@arr_12).should eql 'o'
		  end	
		 	it "returns o if o-player won" do
		 		game.game_board = game_board
		 		game.won?(@arr_13).should be_false
		  end	
		 	it "returns false when no win" do
		 		game.game_board = game_board
		 		game.won?(@arr_14).should be_false
		  end	
		 	it "returns o if o-player won" do
		 		game.game_board = game_board
		 		game.won_horizontal?(@arr_15).should eql('o')
		  end
		end

		describe "#tie?" do
			it "returns false if if there are any unplayed spaces" do
				game.tie?([" "]).should be_false
			end

			it "returns true if all spaces are played" do
				game.tie?(["x"]).should be_true
			end
		end

		describe "#switch_player" do
			game_board = Board.new('x')

			it "switches player to computer player if player was human player" do
				game.game_board = game_board
				game.switch_player(game_board.human_player_symbol).should eql 'o'
			end

			it "switches player to human_player if player was computer_player" do
				game.game_board = game_board
				game.switch_player(game_board.comp_player_symbol).should eql 'x'
			end
		end


		describe "winning_move?" do
			game_board = Board.new('x')
			console = Console.new

			it "returns false if current move can't win" do
				game.console = console
				game.game_board = game_board
				game.winning_move?(@arr_01).should be_false
			end

			it "returns first posible position to win in this move" do
				game.console = console
				game.game_board = game_board
				game.winning_move?(@arr_02).should eql 1
			end

			it "returns first posible position to win in this move" do
				game.console = console
				game.game_board = game_board
				game.winning_move?(@arr_03).should eql 3
			end		

			it "returns first posible position to win in this move" do
				game.console = console
				game.game_board = game_board
				game.winning_move?(@arr_04).should eql 8
			end

		end


		describe "computer_move" do
			game_board = Board.new('x')

			it "returns random nr from [0..8]" do
				game.game_board = game_board
				expect([0,1,2,3,4,5,6,7,8]).to include(game.computer_move(@arr_01))
			end

			it "returns winning move" do
				game.game_board = game_board
				game.computer_move(@arr_03).should eql 3
			end

			it "returns random nr of [1,3,5,7]" do
				game.game_board = game_board
				expect([1,3,5,7]).to include(game.computer_move(@arr_05))
			end

			it "returns the best move" do
				game.game_board = game_board
				game.computer_move(@arr_06).should eql 4
			end

			it "returns safe, not the best to win move" do
				game.game_board = game_board
				game.computer_move(@arr_07).should eql 8
			end
		end
	end
end
