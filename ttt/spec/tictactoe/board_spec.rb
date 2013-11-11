require 'spec_helper'

module TicTacToe
  describe Board do
    let(:game_board) { game_board = Board.new('x') }

    describe "environment settigs" do
      context "create new empty board" do
        it "creates an empty array, lenght 9" do
          game_board.board.should eql [" ", " ", " ", " ", " ", " ", " ", " ", " "]
          #ks [].should be_empty  -doesn't work  -why?
        end
      end

      context "environment settings" do
        it "sets symbol for human as 'x'" do
          game_board.human_player_symbol.should eql 'x'
        end
      end

      context "create empty board" do
        it "sets symbol for computer as 'o'" do
          game_board.comp_player_symbol.should eql 'o'
        end
      end
    end
  end
end