require '../ttt_heuristic'

describe "Action Object" do

	let(:game) { Action.new }

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


	# describe "continue_game?" do
	# 	it "returns true if decided to start new game" do
	# 		game.continue_game?.should be_true
	# 	end

	# 	it "returns false if decided to stop playing" do
	# 		game.continue_game?.should be_false
	# 	end
	# end
end