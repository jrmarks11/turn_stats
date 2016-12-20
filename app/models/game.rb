class Game < ApplicationRecord
  has_many :moves

  def self.find_moves(opts)
    start_time = opts[:start_time] || 100.years.ago
    end_time = opts[:end_date] || DateTime.now
    klass = opts[:class] || '*'
    opponent = opts[:opponent] || '*'
    turn = opts[:turn] || '*'

    games = Game.where("time > ? and time < ?", start_time, end_time)
    games = games.select{|g| g.winner_class == klass || g.loser_class == klass} unless klass == '*'
    games = games.select{|g| g.winner_class == opponent || g.loser_class == opponent} unless opponent == '*'

    if klass == '*'
      moves = games.map(&:moves).flatten
    else
      moves = games.map{|m| m.moves_for(klass)}.flatten
    end

    moves = moves.select!{|m| m.turn == turn.to_i} unless turn == '*' 

    moves
  end

  def import!(data)
    # TODO: this is hacky need to do better error checking and decide whether added is needed
    self.time = DateTime.strptime(data['added'], "%Y-%m-%dT%H") unless data['added'].nil?

    results = {}
    if data['result'] == 'win'
      results = {'winner'=> 'hero', 'loser'=> 'opponent', 'me' => true, 'opponent' => false}
    else
      results = {'winner' => 'opponent', 'loser' => 'hero', 'me' => false, 'opponent' => true}
    end

    self.winner_class = data[results['winner']]
    self.winner_deck = data["#{results['winner']}_deck"]
    self.loser_class = data[results['loser']]
    self.loser_deck = data["#{results['loser']}_deck"]
    self.save!

    # TODO: this also could be nicer
    if(data.has_key?('card_history'))
      data['card_history'].each do |move|
        add_move(move, results[move['player']])
      end
    end
  end

  def add_move(data, win)
    new_move = self.moves.new
    new_move.import!(data, win)
  end

  def moves_for(klass)
    moves_for_select(klass, self.moves)
  end


  private
  def moves_for_select(klass, moves)
    result = []
    result << moves.select{|m| m.winner} if klass == self.winner_class
    result << moves.select{|m| !m.winner} if klass == self.loser_class
    result.flatten
  end
end
