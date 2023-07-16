class Game < ApplicationRecord
  belongs_to :user
  belongs_to :user_persona, class_name: 'Persona', foreign_key: 'user_persona_id'
  belongs_to :computer_persona, class_name: 'Persona', foreign_key: 'computer_persona_id'
end
