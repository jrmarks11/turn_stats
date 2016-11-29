class GameLoader
  def initialize
    @api = TrackOBotAPI.new
  end

  def load_all
    load(pages: pages)
  end

  def load(options ={})
    load_pages = options[:pages] || 1

    1.upto(load_pages) do |page|
      load_db(history(:page => page))
    end
  end

  def history(options)
    @api.history options
  end

  def pages
    @api.pages
  end

  def load_db(his)
    puts "____________________________________LOADING_____________________________________"
    puts his['meta'].to_s
    puts "________________________________________________________________________________"
    
    his['history'].each do |game|
      db_game = Game.find_or_create_by(trackobot_id: game['id'])
      db_game.import!(game)
    end
  end
end