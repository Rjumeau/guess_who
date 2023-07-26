class RoundsController < ApplicationController
  before_action :find_game, only: %i[new create]
  before_action :set_common_variables, only: %i[new create]

  def new
    @round = Round.new
  end

  def adjectives
    adjectives = Persona.find_feature_adjectives(params[:feature])
    render json: { adjectives: adjectives }
  end

  def create
    @round = Round.new(round_params)
    @round.game = @game
    @round.add_computer_choice
    if @round.computer_has_guess?
      @game.winning_computer_game
      redirect_to new_game_path, loose: "Computer has guess your persona"
    else
      @round.create_round_logic(round_params)
      if @round.save
        redirect_to new_game_round_path(@game)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

  def set_common_variables
    @all_personas = Persona.all
    @previous_round = @game.last_round
    @computer_personas = @game.find_remaining_computer_personas_list(:remaining_computer_personas)
    @user_personas = @game.find_remaining_user_personas_list(:remaining_user_personas)
    @personas_characteristics = Persona.list_personas_characteristics
  end

  def round_params
    params.require(:round).permit(:user_adjective, :user_feature)
  end
end
