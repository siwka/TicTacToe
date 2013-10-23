require '../ttt_heuristic'

# def initialize
# 	input_players[0] = 'o'
# 	it 'returns x for computer' do
# 		input_players[1].should eql 'x'
# 	end
# end

describe "#initialize" do

	input_players[0] = 'o'
	it 'returns x for computer' do
		input_players[1].should eql 'x'
	end

	input_players[0] = 'x'
	it 'returns o for computer' do
		input_players[1].should eql 'o'
	end

	input_players[2] = 'y'
	it 'returns human_player as start_player' do
		input_players[2].should eql $human_player
	end

	input_players[2] = 'n'
	it 'returns human_player as start_player' do
		input_players[2].should eql $computer_player
	end
end