require 'spec_helper'

module TicTacToe
  describe Console do
    let(:console) { console = Console.new }
    #let(:board)   { board = Board.new('x')}

    describe "setting new game" do

      it 'prompts for who starts a game' do
        pending "puts removes str, decide Console or output to pass test"
        console.who_starts?.should == 'Who is going to make first move: 1-you, 2-computer?:'
        #console.should_receive(:puts).with('Who is going to make first move: 1-you, 2-computer?')
      end

      it 'prompts for human player symbol' do
        pending "puts removes str, decide Console or output to pass test"
        console.chose_symbol?.should ==  'Choose o or x:'
      end

      it 'receives human starts a game' do
        #console.human_starts?.should eql 1
        expect([1,2]).to include(console.human_starts?)
      end

    end
  end
end