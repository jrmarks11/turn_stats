require 'rails_helper'

RSpec.describe Game, type: :model do

  describe "attributes" do
    context "a new object" do
      let(:game) {build :game_one}

      it "responds to trackobot_id" do
        expect(game.trackobot_id).to eql 49923902
      end

      it "responds to winner_class" do
        expect(game.winner_class).to eql 'Paladin'
      end

      it "responds to winner_deck" do
        expect(game.winner_deck).to eql "N'Zoth"
      end      

      it "responds to loser_class" do
        expect(game.loser_class).to eql 'Paladin'
      end

      it "responds to loser_deck" do
        expect(game.loser_deck).to be nil
      end

      it "has moves" do
        expect(game.moves).to match_array []
      end

    end
  end

end
