class Game < ApplicationRecord
  has_many :rounds

  belongs_to :user
  belongs_to :user_persona, class_name: 'Persona', foreign_key: 'user_persona_id'
  belongs_to :computer_persona, class_name: 'Persona', foreign_key: 'computer_persona_id'

  enum winner: %i[pending user_win computer_win]

  def add_computer_persona
    self.computer_persona = Persona.sample_computer_persona(user_persona)
  end

  def last_round_position
    rounds.last&.position || 0
  end

  def last_round_personas_list(attribute_name)
    rounds.last&.send(attribute_name)
  end
end
