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
end
