require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "class methods" do
    context "#moves" do
      it "finds the win % of a group of moves" do
        moves = create(:sixtey_seven).moves
        moves_2 = create(:twenty_five).moves

        expect(Report.moves(moves)).to match_array [{name: 'Axe', count: 3, percent: 67}]
        expect(Report.moves(moves_2)).to match_array [{name: 'Axe', count: 4, percent: 25}]
      end

      it "works on groups of moves with mulitple types of moves" do
        moves = create(:two_moves_game).moves
        expected_result = [{name: 'Axe', count: 2, percent: 50}, {name: 'Ghoul', count: 1, percent: 100}]

        expect(Report.moves(moves)).to match_array expected_result
      end
    end
  end
end
