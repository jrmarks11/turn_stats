class AddTimeToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :time, :datetime
  end
end
