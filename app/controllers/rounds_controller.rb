class RoundsController < ApplicationController
  before_action :find_game, only: %i[new create]

  def new
    @round = Round.new
    @all_personas = Persona.all
    @previous_round = @game.last_round
    @computer_personas = @game.find_remaining_computer_personas_list(:remaining_computer_personas)
    @user_personas = @game.find_remaining_user_personas_list(:remaining_user_personas)
    @personas_characteristics = Persona.list_personas_characteristics
  end

  def adjectives
    adjectives = Persona.find_feature_adjectives(params[:feature])
    render json: { adjectives: adjectives }
  end

  def create
    @round = Round.new(round_params)
    @round.game = @game
    @round.add_computer_choice
    if @round.computer_has_a_guess?
      @game.check_computer_guess(@round.computer_guess)
      redirect_to new_game_path
    else
      @round.position = @game.last_round_position + 1
      @round.create_computer_remaining_personas_list(round_params)
      @round.create_user_remaining_personas_list(@round.computer_feature, @round.computer_adjective)
      if @round.save
        redirect_to new_game_round_path(@game)
      else
        render 'new', status: :unprocessable_entity
      end
    end
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

  def round_params
    params.require(:round).permit(:user_adjective, :user_feature)
  end
end
