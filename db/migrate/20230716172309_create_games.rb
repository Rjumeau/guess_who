class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :user_persona_id
      t.integer :computer_persona_id
      t.integer :winner

      t.timestamps
    end
  end
end
