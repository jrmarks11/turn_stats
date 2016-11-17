class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :trackobot_id
      t.string :winner_class
      t.string :loser_class
      t.string :winner_deck
      t.string :loser_deck
      
      t.timestamps
    end
  end
end
