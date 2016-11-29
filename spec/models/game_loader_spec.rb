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
