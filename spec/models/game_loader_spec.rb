require 'rails_helper'

RSpec.describe GameLoader, type: :model do
  let(:loader) {GameLoader.new}

  describe "#load" do
    it "should call the tracobot api and load the db for each page" do
      expect(loader).to receive(:history).with(page: 1)
      expect(loader).to receive(:load_db)
      loader.load

      expect(loader).to receive(:history).with(page: 1)
      expect(loader).to receive(:history).with(page: 2)
      expect(loader).to receive(:history).with(page: 3)
      expect(loader).to receive(:load_db).exactly(3).times
      loader.load(:pages => 3)
    end
  end

  describe "#load_db" do
    it "should import game data into the database" do
      fake_history = {'history' => [{'id'=>1}, {'id'=>2}, {'id'=>3}]}
      loader.load_db(fake_history)

      expect(Game.count).to eql 3
      expect(Game.all.map(&:trackobot_id)).to match_array [1, 2, 3]
    end

    it "should not import if a game has already been imported" do
        move_1 = {"player"=>"me", "turn"=>1,"card"=>{"id"=>"EX1_509", "name"=>"Murloc Tidecaller", "mana"=>1}}
        move_2 = {"player"=>"opponent", "turn"=>1, "card"=>{"id"=>"GAME_005", "name"=>"The Coin", "mana"=>nil}}

        data = {'history' => [{"id"=>51522331, "mode"=>"ranked", "hero"=>"Warlock", "hero_deck"=>"Murloc", "opponent"=>"Guldan",
          "opponent_deck"=>"Reno", "coin"=>false, "result"=>"win", "duration"=>209, "rank"=>18, "legend"=>nil, "note"=>nil,
          "added"=>"2016-11-28T02:27:59.000Z", "card_history"=>[move_1, move_2]
        }]}

        2.times do 
          loader.load_db(data)
          expect(Game.count).to eql 1
          expect(Move.count).to eql 2
        end
    end
  end

  describe "#load_all" do
    it "should query the api for the number of pages and then load each page" do
      expect(loader).to receive(:pages).and_return(4)
      expect(loader).to receive(:history).with(page: 1)
      expect(loader).to receive(:history).with(page: 2)
      expect(loader).to receive(:history).with(page: 3)
      expect(loader).to receive(:history).with(page: 4)
      expect(loader).to receive(:load_db).exactly(4).times
      loader.load_all
    end
  end
end
