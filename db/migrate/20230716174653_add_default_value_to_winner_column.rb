class AddDefaultValueToWinnerColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :games, :winner, :integer, default: 0
  end
end
