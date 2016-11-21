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
end
