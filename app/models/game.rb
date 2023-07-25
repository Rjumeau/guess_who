class Game < ApplicationRecord
  has_many :rounds

  belongs_to :user
  belongs_to :user_persona, class_name: 'Persona', foreign_key: 'user_persona_id'
  belongs_to :computer_persona, class_name: 'Persona', foreign_key: 'computer_persona_id'

  enum winner: %i[pending user_win computer_win]

  %w[user computer].each do |player|
    define_method("find_remaining_#{player}_personas_list") do |player_personas|
      if list_last_round_personas(player_personas)
        personas_data = JSON.parse(list_last_round_personas(player_personas))
        # Make sure that the persona collection has the same order as
        # the remaining personas round attribute
        Persona.find_and_sort_by_ids(personas_data)
      else
        Persona.all
      end
    end

    define_method("winning_#{player}_persona_has_characteristics?") do |characteristics, opponent|
      send("#{player}_persona")
        .send(characteristics["#{opponent}_feature".to_sym]) == characteristics["#{opponent}_adjective".to_sym]
    end

    define_method("good_#{player}_persona?") do |player_guess|
      send("#{player}_persona").name == player_guess
    end

    define_method("last_round_#{player}_feature") do
      rounds.last&.send("#{player}_feature")
    end

    define_method("last_round_#{player}_adjective") do
      rounds.last&.send("#{player}_adjective")
    end

    define_method("#{player}_persona_picture") do
      send("#{player}_persona").picture
    end
  end

  def self.last_user_game(current_user)
    where(user: current_user).last
  end

  def add_computer_persona
    self.computer_persona = Persona.sample_computer_persona(user_persona)
  end

  def check_computer_guess(computer_guess)
    if good_user_persona?(computer_guess)
      flash[:loose] = "Computer has guess your persona"
      self.computer_guess = computer_guess
      computer_win!
    end
  end

  def check_user_guess(user_guess)
    if good_computer_persona?(user_guess)
      flash[:win] = user_persona_picture
      self.user_guess = game_params[:user_guess]
      user_win!
    else
      flash[:loose] = "Computer persona was"
      computer_win!
    end
  end

  def last_round_position
    rounds.last&.position || 0
  end

  def previous_remaining_personas(player_personas)
    remaining_personas = list_last_round_personas(player_personas)
    remaining_personas ? JSON.parse(remaining_personas) : JSON.parse(Persona.all.to_json)
  end

  def list_last_round_personas(player_personas)
    rounds.last&.send(player_personas)
  end

  def previous_attempts
    rounds.map { |round| { computer_feature: round.computer_feature, computer_adjective: round.computer_adjective } }
  end

  def last_round
    rounds.last
  end
end
