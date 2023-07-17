class RoundsController < ApplicationController
  def new
    @round = Round.new
    @game = Game.find(params[:game_id])
    @all_personas = Persona.all
    @personas_characteristics = @round.list_round_personas_characteristics
  end

  def adjectives
    personas_characteristics = Persona.list_personas_characteristics
    selected_feature = params[:feature]
    adjectives = personas_characteristics[selected_feature]
    render json: { adjectives: adjectives }
  end
end
