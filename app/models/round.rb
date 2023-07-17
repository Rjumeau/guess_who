class Round < ApplicationRecord
  belongs_to :game

  def list_round_personas_characteristics
    Persona.list_personas_characteristics
  end
end
