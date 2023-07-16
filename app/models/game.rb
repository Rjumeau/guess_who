class Game < ApplicationRecord
  belongs_to :user
  belongs_to :user_persona, class_name: 'Persona', foreign_key: 'user_persona_id'
  belongs_to :computer_persona, class_name: 'Persona', foreign_key: 'computer_persona_id'

  enum winner: %i[pending user_win computer_win]

  def add_computer_persona
    self.computer_persona = Persona.sample_computer_persona(user_persona)
  end
end
