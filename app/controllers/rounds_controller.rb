class RoundsController < ApplicationController
  def new
    @round = Round.new
    @game = Game.find(params[:game_id])
    @all_personas = Persona.all
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
      redirect_to new_game_round_path(@game)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def round_params
    params.require(:round).permit(:user_adjective, :user_feature)
  end
end
