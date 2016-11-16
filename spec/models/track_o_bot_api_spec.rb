require 'rails_helper'

RSpec.describe TrackOBotAPI, type: :model do
  let(:client) {TrackOBotAPI.new}

  describe "#history" do
    it "should return the first page of history with no arguments" do
      VCR.use_cassette('trackobot/history') do
        history = client.history

        expect(history.code).to eql 200
        expect(history.keys.count).to eql 2
        expect(history['meta'].keys).to match_array ['current_page', 'next_page', 'prev_page', 'total_pages', 'total_items']
        expect(history['history'].count).to eql 15
        expect(history['meta']['current_page']).to eql 1
      end
    end
  end
end
