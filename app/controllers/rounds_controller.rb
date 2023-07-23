class RoundsController < ApplicationController
  def new
    @round = Round.new
    @game = Game.find(params[:game_id])
    if @game.last_round_personas_list(:remaining_user_personas)
      @user_personas = @round.find_remaining_personas_list(@game, :remaining_user_personas)
    else
      @user_personas = Persona.all
    end
    @computer_personas = Persona.all
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
    @round.position = @game.last_round_position + 1
    # Renvoyer une collection de Persona selon la user_feature et le user_adjective
    @round.create_remaining_personas_list(@game, round_params)
    # Sélectionner une computer_feature et computer_adjective selon la collection restante pour le user
    # Renvoyer une collection de Persona selon la computer_feature et le computer_adjective
    if @round.save
      redirect_to new_game_round_path(@game)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def round_params
    params.require(:round).permit(:user_adjective, :user_feature)
  end
end
