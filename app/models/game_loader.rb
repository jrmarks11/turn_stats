class GameLoader
  def initialize
    @api = TrackOBotAPI.new
  end

  def load(options ={})
    pages = options[:pages] || 1

    1.upto(pages) do |page|
      load_db(history(:page => page))
    end
  end

  def history(options)
    # @api.history options
  end

  def load_db(his)
  end
end