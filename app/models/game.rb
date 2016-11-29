class Game < ApplicationRecord
  has_many :moves

  def import!(data)
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
end
