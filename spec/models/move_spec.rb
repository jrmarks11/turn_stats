require 'rails_helper'

RSpec.describe Move, type: :model do

  describe "attributes" do
    context "a new object" do
      let(:move) {build :move_one}

      it "responds to winner" do
        expect(move.winner).to be true
      end

      it "responds to turn" do
        expect(move.turn).to eql 3
      end

      it "responds to card_name" do
        expect(move.card_name).to eql 'Tomb Pillager'
      end
    end
  end

  describe "methods" do
    context "#import!" do
      it "should import data" do
        move_1 = {"player"=>"me", "turn"=>1,"card"=>{"id"=>"EX1_509", "name"=>"Murloc Tidecaller", "mana"=>1}}
        move_2 = {"player"=>"opponent", "turn"=>2, "card"=>{"id"=>"GAME_005", "name"=>"The Coin", "mana"=>nil}}
       
        g = Game.new
        m = g.moves.new

        m.import!(move_1, true)
        expect(m.turn).to eql 1
        expect(m.card_name).to eql 'Murloc Tidecaller'
        expect(m.winner).to be true
        
        m.import!(move_2, false)
        expect(m.turn).to eql 2
        expect(m.card_name).to eql 'The Coin'
        expect(m.winner).to be false
      end
    end
  end
end
