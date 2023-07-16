class AddUserAndComputerValidationToRounds < ActiveRecord::Migration[7.0]
  def change
    add_column :rounds, :user_validation, :boolean, default: false
    add_column :rounds, :computer_validation, :boolean, default: false
  end
end
