class TrackOBotAPI
  include HTTParty
  
  base_uri "https://trackobot.com"

  def initialize()
    @auth = YAML.load_file('config/track_o_bot.yml')
  end

  def history(options={})
    query_options = @auth.merge options
    self.class.get('/profile/history.json', query: query_options)
  end
end