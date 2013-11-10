require 'spec_helper'

module TicTacToe
	describe Game do
		describe "#start" do
			let(:output) { double('output').as_null_object }
			let(:game) { Game.new(output) }

			it 'sends a welcome message' do
				output.should_receive(:puts).with('Welcome to tic tac toe!')
				game.start
			end

			it "prompts for who starts a game" do
				output.should_receive(:puts).with('Who is going to make first move: 1-you, 2-computer?:')
				game.start
			end

			it "prompts to chose symbol x or o" do
				output.should_receive(:puts).with('Choose o or x:')
				game.start
			end
		end
	end
end
