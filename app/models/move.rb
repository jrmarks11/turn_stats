class Move < ApplicationRecord
  belongs_to :game
  
  def import!(data, win)
    self.turn = data['turn']
    self.card_name = data['card']['name']
    self.winner = win
    self.save!
  end
end
