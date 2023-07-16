class AddPictureColumnToPersonas < ActiveRecord::Migration[7.0]
  def change
    add_column :personas, :picture, :string
  end
end
