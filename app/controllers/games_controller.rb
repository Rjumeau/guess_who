class GamesController < ApplicationController
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
    @game = Game.find(params[:id])
    if params[:user_guess] && @game.good_user_guess?(game_params[:user_guess])
      flash[:notice] = "Congratulations ! You won !\n Computer persona was #{@game.computer_persona}"
    end
    redirect_to new_game_round_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:user_persona_id, :user_guess)
  end
end
