class GamesController < ApplicationController
  before_action :find_game, only: %i[update]

  def start_or_resume
    @last_user_game = Game.last_user_game(current_user)
  end

  def new
    @game = Game.new
    @all_personas = Persona.all
    @last_computer_persona_picture = Game.last_computer_persona_picture(current_user)
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    @game.add_computer_persona
    if @game.save
      redirect_to new_game_round_path(@game)
    else
      @all_personas = Persona.all
      @last_computer_persona_picture = Game.last_computer_persona_picture(current_user)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @game.good_computer_persona?(game_params[:user_guess])
      @game.winning_user_game(game_params[:user_guess])
      redirect_to new_game_path, win: "Congratulations"
    else
      @game.winning_computer_game
      redirect_to new_game_path, loose: "Bad guess !"
    end
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:user_persona_id, :user_guess)
  end
end
