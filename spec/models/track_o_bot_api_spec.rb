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

    it "should allow me to query for a specific page" do
      VCR.use_cassette('trackobot/page3') do
        history =  client.history :page => 3

        expect(history.code).to eql 200
        expect(history['history'].count).to eql 15
        expect(history['meta']['current_page']).to eql 3
      end

    end
  end

  describe "#pages" do
    it "should allow me to find out how many pages i have in my history" do
      VCR.use_cassette('trackobot/pages') do
        expect(client.pages).to eql 226
      end
    end
  end
end
