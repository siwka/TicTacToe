require '../ttt_heuristic'

describe "Action Object" do

	let(:game) { Action.new }
	$computer_player = 'x'
	$human_player = 'o'

	
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

	# def tie (board) 
	# # tie if there is no more moves, meaning no space in array
	# # to simplyfy we assume that won() was called before tie()
	# 	return board.none? { |b| b == " " }
	# end # def tie (board)


	describe "tie" do

		it "returns false if if there are any unplayed spaces" do
			game.tie([" "]).should be_false
		end

		it "returns true if all spaces are played" do
			game.tie(["x"]).should be_true
		end

	end


	describe "switch_player" do

		it "switches player to computer_player if player was human_player" do
			game.switch_player($human_player).should eql $computer_player
		end

		it "switches player to human_player if player was computer_player" do
			game.switch_player($human_player).should eql $computer_player
		end
	end


	describe "winning_move?" do

		it "returns false if current move can't win" do
			game.winning_move?(@arr_01).should be_false
		end

		it "returns first posible position to win in this move" do
			game.winning_move?(@arr_02).should eql 1
		end

		it "returns first posible position to win in this move" do
			game.winning_move?(@arr_03).should eql 3
		end		

		it "returns first posible position to win in this move" do
			game.winning_move?(@arr_04).should eql 3
		end

	end


	describe "computer_move" do

		it "returns random nr from [0..8]" do
			expect([0,1,2,3,4,5,6,7,8]).to include(game.computer_move(@arr_01))
		end

		it "returns winning move" do
			game.computer_move(@arr_03).should eql 3
		end

		it "returns random nr of [1,3,5,7]" do
			expect([1,3,5,7]).to include(game.computer_move(@arr_05))
		end

		it "returns the best move" do
			game.computer_move(@arr_06).should eql 4
		end

		it "returns the best move" do
			game.computer_move(@arr_07).should eql 8
		end

	end

end