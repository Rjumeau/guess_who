class AddRemainingUserAndComputerPersonaToRounds < ActiveRecord::Migration[7.0]
  def change
    add_column :rounds, :remaining_user_personas, :json
    add_column :rounds, :remaining_computer_personas, :json
  end
end
