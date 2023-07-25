class Round < ApplicationRecord
  belongs_to :game

  def computer_choice
    remaining_user_personas = game.previous_remaining_personas(:remaining_user_personas)

    # Remove last computer adjective from remaining user personnas to avoid same attempt
    remaining_user_personas = delete_last_computer_attempt(remaining_user_personas) if game.rounds.last

    characteristics_frequencies = {}

    count_characteristics_frequencies(characteristics_frequencies, remaining_user_personas)

    best_occurence = find_best_characteristic_occurence(characteristics_frequencies)

    self.computer_feature = best_occurence[0]
    # Find the key of the adjectives subhash with the highest value
    self.computer_adjective = best_occurence[1].key(best_occurence[1].values.max)
  end

  def create_computer_remaining_personas_list(player_attempt)
    remaining_computer_personas = game.previous_remaining_personas(:remaining_computer_personas)

    if game.winning_computer_persona_has_characteristics?(player_attempt, :user)
      new_remaining_computer_personas = filter_personas_list(remaining_computer_personas, :user, player_attempt)
      self.user_validation = true
    else
      new_remaining_computer_personas = remaining_computer_personas
      self.user_validation = false
    end

    self.remaining_computer_personas = new_remaining_computer_personas.to_json
  end

  def create_user_remaining_personas_list(computer_feature, computer_adjective)
    remaining_user_personas = game.previous_remaining_personas(:remaining_user_personas)
    player_attempt = { computer_feature: computer_feature, computer_adjective: computer_adjective }

    if game.winning_user_persona_has_characteristics?(player_attempt, :computer)
      new_remaining_user_personas = filter_personas_list(remaining_user_personas, :computer, player_attempt)
      self.computer_validation = true
    else
      new_remaining_user_personas = remaining_user_personas
      self.computer_validation = false
    end

    self.remaining_user_personas = new_remaining_user_personas.to_json
  end

  private

  def delete_last_computer_attempt(remaining_user_personas)
    remaining_user_personas.map do |persona|
      persona.delete_if do |feature, adjective|
        feature == game.rounds.last.computer_feature && adjective == game.rounds.last.computer_adjective
      end
    end
  end

  def count_characteristics_frequencies(characteristics_frequencies, remaining_user_personas)
    remaining_user_personas.each do |persona|
      persona.each do |feature, adjective|
        unless %w[id picture name created_at updated_at].include?(feature) || adjective == "Missing"
          characteristics_frequencies[feature] ||= Hash.new(0)
          characteristics_frequencies[feature][adjective] += 1
        end
      end
    end
  end

  def find_best_characteristic_occurence(characteristics_frequencies)
    characteristics_frequencies.max_by { |_, adjectives| adjectives.values }
  end

  def filter_personas_list(remaining_personas, player, player_attempt)
    remaining_personas.select do |persona|
      persona[player_attempt["#{player}_feature".to_sym]] == player_attempt["#{player}_adjective".to_sym]
    end
  end
end
