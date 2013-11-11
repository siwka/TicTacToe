require 'spec_helper'

module TicTacToe
	describe Game do
		let(:output) { double('output').as_null_object }
		let(:game) { Game.new(output) }
		
		describe "#start" do
			# let(:output) { double('output').as_null_object }
			# let(:game) { Game.new(output) }

			it 'sends a welcome message' do
				output.should_receive(:puts).with("Welcome to tic tac toe!\n")
				game.start
			end

			it "prints information to use numeric pad pattern" do
				output.should_receive(:puts).with("\nLet's set a game:\n")
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

		describe "tie?" do
			it "returns false if if there are any unplayed spaces" do
				game.tie?([" "]).should be_false
			end

			it "returns true if all spaces are played" do
				game.tie?(["x"]).should be_true
			end

		end

	end
end
