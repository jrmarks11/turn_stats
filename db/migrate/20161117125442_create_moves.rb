class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.integer :game_id
      t.foreign_key :games
      t.boolean :winner
      t.integer :turn
      t.string :card_name
      t.timestamps
    end
  end
end
