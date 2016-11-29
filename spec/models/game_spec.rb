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

  describe "#import!" do
    it "should import winner and loser class and deck" do
      loss = {"hero"=>"Warlock", "hero_deck"=>"Murloc", "opponent"=>"Guldan", "opponent_deck"=>"Reno", "result"=>"loss"}
      win = {"hero"=>"Warlock", "hero_deck"=>"Murloc", "opponent"=>"Guldan", "opponent_deck"=>"Reno", "result"=>"win"}
      
      lost_game = Game.new
      lost_game.import!(loss)
      expect(lost_game.winner_class).to eql 'Guldan'
      expect(lost_game.loser_class).to eql 'Warlock'
      expect(lost_game.winner_deck).to eql 'Reno'
      expect(lost_game.loser_deck).to eql 'Murloc'

      won_game = Game.new
      won_game.import!(win)
      expect(won_game.winner_class).to eql 'Warlock'
      expect(won_game.loser_class).to eql 'Guldan'
      expect(won_game.winner_deck).to eql 'Murloc'
      expect(won_game.loser_deck).to eql 'Reno'
    end

    it "should import moves" do
      move_1 = {"player"=>"me", "turn"=>1,"card"=>{"id"=>"EX1_509", "name"=>"Murloc Tidecaller", "mana"=>1}}
      move_2 = {"player"=>"opponent", "turn"=>1, "card"=>{"id"=>"GAME_005", "name"=>"The Coin", "mana"=>nil}}
      move_3 = {"player"=>"opponent", "turn"=>1, "card"=>{"id"=>"LOE_023", "name"=>"Dark Peddler", "mana"=>2}}
      move_4 = {"player"=>"me", "turn"=>2, "card"=>{"id"=>"EX1_506", "name"=>"Murloc Tidehunter", "mana"=>2}}

      data = { "id"=>51522331, "mode"=>"ranked", "hero"=>"Warlock", "hero_deck"=>"Murloc", "opponent"=>"Guldan",
        "opponent_deck"=>"Reno", "coin"=>false, "result"=>"win", "duration"=>209, "rank"=>18, "legend"=>nil, "note"=>nil,
        "added"=>"2016-11-28T02:27:59.000Z", "card_history"=>[move_1, move_2, move_3, move_4]
      }
      game = Game.new
      expect(game).to receive(:add_move).with(move_1, true)
      expect(game).to receive(:add_move).with(move_2, false)
      expect(game).to receive(:add_move).with(move_3, false)
      expect(game).to receive(:add_move).with(move_4, true)
      game.import!(data)
    end
  end

  describe "#add_move" do
    it "should add a move" do
      move_1 = {"player"=>"me", "turn"=>1,"card"=>{"id"=>"EX1_509", "name"=>"Murloc Tidecaller", "mana"=>1}}
      game = build :game_one
      game.add_move(move_1, true)

      expect(game.moves.count).to eql 1
    end
  end

end
