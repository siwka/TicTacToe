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

			@arr_05 = ["o", " ", " ",
					  		 " ", "x", " ",
					  		 " ", " ", "o"]

			@arr_06 = [" ", "o", " ",   # one best move
					  		 " ", " ", "x",
					  		 " ", "x", "o"]


			@arr_07 = [" ", "o", " ",   # best move 6 lead to lose -> remove human best
					  		 " ", "x", "o",
					  		 " ", "x", " "]	
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
		 		game.won_horizontal?(@arr_08).should be_false
		  end
		 	it "returns x upon x-player win" do
		 		game.won_horizontal?(@arr_09).should eql 1
		  end
		 	it "returns x if x-player won" do
		 		game.won?(@arr_10).should eql 1
		  end
		 	it "returns o if o-player won" do
		 		game.won?(@arr_11).should eql 2
		  end	
		 	it "returns o if o-player won" do
		 		game.won?(@arr_12).should eql 2
		  end	
		 	it "returns o if o-player won" do
		 		game.won?(@arr_13).should be_false
		  end	
		 	it "returns false when no win" do
		 		game.won?(@arr_14).should be_false
		  end	
		 	it "returns o if o-player won" do
		 		game.won_horizontal?(@arr_15).should eql(2)
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
			# game_board = Board.new('x')

			it "switches player to computer player if player was human player" do
				pending "dependency injection works but program :-( for:"
				game.switch_player(game_board.human_player_symbol, game_board).should eql 'o'
			end

			it "switches player to human_player if player was computer_player" do
				pending "switch_player(current_player, game_board), game_board = Board.new('x')"
				game.switch_player(game_board.comp_player_symbol, game_board).should eql 'x'
			end
		end


		describe "winning_move?" do

			#ks new aproach
			# class Board
			# attr_reader :board_dimention
			 
			# def board_dimention
			# 	return 3
			# end
			# end
			# @game_board = Board.new
			# @game_board.board_dimention = 3
 			#    def winning_move?(board)
      #    n = @game_board.board_dimention - commented for test

      				# pending "problem: generally avoid using instance variables in your tests, as they silently default to nil when referenced if uninitialized"


			xit "returns false if current move can't win" do
				game.winning_move?(@arr_01).should be_false
			end

			xit "returns first posible position to win in this move" do
				game.winning_move?(@arr_02).should eql 1
			end

			xit "returns first posible position to win in this move" do
				game.winning_move?(@arr_03).should eql 3
			end		

			xit "returns first posible position to win in this move" do
				game.winning_move?(@arr_04).should eql 3
			end

		end


		# describe "computer_move" do

		# 	it "returns random nr from [0..8]" do
		# 		expect([0,1,2,3,4,5,6,7,8]).to include(game.computer_move(@arr_01))
		# 	end

		# 	it "returns winning move" do
		# 		game.computer_move(@arr_03).should eql 3
		# 	end

		# 	it "returns random nr of [1,3,5,7]" do
		# 		expect([1,3,5,7]).to include(game.computer_move(@arr_05))
		# 	end

		# 	it "returns the best move" do
		# 		game.computer_move(@arr_06).should eql 4
		# 	end

		# 	it "returns safe, not the best to win move" do
		# 		game.computer_move(@arr_07).should eql 8
		# 	end
		# end
	end
end
