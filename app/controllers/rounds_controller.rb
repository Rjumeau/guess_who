class RoundsController < ApplicationController
  def new
    @round = Round.new
    @game = Game.find(params[:game_id])
    if params[:remaining_personas]
      @personas = params[:remaining_personas]
    else
      @personas = Persona.all
    end
    @personas_characteristics = Persona.list_personas_characteristics
  end

  def adjectives
    adjectives = Persona.find_feature_adjectives(params[:feature])
    render json: { adjectives: adjectives }
  end

  def create
    @game = Game.find(params[:game_id])
    @round = Round.new(round_params)
    @round.game = @game

    if @round.save
      remaining_personas = Persona.filter_matching_personas(persona_params)
      redirect_to new_game_round_path(@game, remaining_personas: remaining_personas)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def round_params
    params.require(:round).permit(:user_adjective, :user_feature)
  end

  def persona_params
    params.require(:round).permit(:remaining_personas)
  end
end
