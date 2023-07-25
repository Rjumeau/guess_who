class GamesController < ApplicationController
  before_action :find_game, only: %i[update]

  def start_or_resume
    @last_user_game = Game.last_user_game(current_user)
  end

  def new
    @game = Game.new
    @all_personas = Persona.all
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    @game.add_computer_persona
    if @game.save
      redirect_to new_game_round_path(@game)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    @game.check_user_guess(game_params)
    redirect_to new_game_path
  end

  private

  def find_game
    Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:user_persona_id, :user_guess)
  end
end
