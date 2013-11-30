require 'spec_helper'

module TicTacToe
  describe Console do
    let(:console) { console = Console.new }


    describe "setting new game" do

      it 'prompts for who starts a game' do
        pending "puts removes str, decide Console or output to pass test"
        # console.who_starts?.should == 'Who is going to make first move: 1-you, 2-computer?:'
        #console.should_receive(:puts).with('Who is going to make first move: 1-you, 2-computer?')
        console.who_starts?.should eq( "Do you want to make a first move (y/n)?")
      end

      it 'prompts for human player symbol' do
        pending "puts removes str, decide Console or output to pass test"
        console.chose_symbol?.should ==  'Choose your player symbol o or x:'
      end

      it 'receives human starts a game' do
        pending "works with getc but for gets: undefined method `chomp' for nil:NilClass"
        console.human_starts?.should be_true
      end

    end
  end
end