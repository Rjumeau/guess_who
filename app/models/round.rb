class Round < ApplicationRecord
  belongs_to :game

  def create_remaining_personas_list(round_params)
    remaining_computer_personas = JSON.parse(round_params[:remaining_computer_personas])
    remaining_user_personas = JSON.parse(round_params[:remaining_user_personas])

    new_remaining_user_personas = remaining_user_personas.reject do |user_persona|
      filter_personas_list(user_persona, round_params[:user_feature], round_params[:user_adjective])
    end

    {
      computer_personas: remaining_computer_personas,
      user_personas: new_remaining_user_personas
    }
  end

  private

  def filter_personas_list(persona, feature, adjective)
    persona[feature] == adjective
  end
end
