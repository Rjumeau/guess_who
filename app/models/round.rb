class Round < ApplicationRecord
  belongs_to :game

  def create_remaining_personas_list(game, round_params)
    remaining_computer_personas = Round.previous_remaining_personas(game, :remaining_computer_personas)
    remaining_user_personas = Round.previous_remaining_personas(game, :remaining_user_personas)

    new_remaining_user_personas = remaining_user_personas.reject do |user_persona|
      filter_personas_list(user_persona, round_params[:user_feature], round_params[:user_adjective])
    end

    self.remaining_user_personas = new_remaining_user_personas.to_json
    self.remaining_computer_personas = remaining_computer_personas.to_json
  end

  def find_remaining_personas_list(game, attribute_name)
    personas_data = JSON.parse(game.last_round_personas_list(attribute_name))

    personas_ids = personas_data.map { |persona_data| persona_data['id'] }

    # Make sure that the persona collection has the same order as
    # the remaining persona round attribute
    Persona.find_and_sort_by_ids(personas_ids)
  end

  def self.previous_remaining_personas(game, attribute_name)
    remaining_personas = game.last_round_personas_list(attribute_name)
    remaining_personas ? JSON.parse(remaining_personas) : Persona.all
  end

  private

  def filter_personas_list(persona, feature, adjective)
    persona[feature] == adjective
  end
end
