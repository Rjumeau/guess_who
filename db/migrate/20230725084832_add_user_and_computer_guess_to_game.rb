class AddUserAndComputerGuessToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :user_guess, :string
    add_column :games, :computer_guess, :string
  end
end
