class Persona < ApplicationRecord
  has_many :games

  before_validation :capitalize_attributes

  EXCLUDED_ATTRIBUTES = %w[id created_at updated_at picture name].freeze
  PLURALS_FEATURES = %w[hair_color hair_length eyes glasses earrings].freeze

  def self.sample_computer_persona(user_persona)
    all.reject { |persona| persona == user_persona }.sample
  end

  def self.computer_selection(personas)
  end

  def self.find_feature_adjectives(feature)
    personas_characteristics = list_personas_characteristics
    personas_characteristics[feature]
  end

  # Store valid feature/adjective couples in a hash to display it in select input
  def self.list_personas_characteristics
    usable_features = list_features

    personas_hash = {}

    usable_features.each do |feature|
      personas_hash[feature] = list_feature_adjectives(feature)
    end

    personas_hash
  end

  def self.list_features
    attribute_names.reject do |attr_name|
      EXCLUDED_ATTRIBUTES.include?(attr_name)
    end
  end

  def self.list_feature_adjectives(feature)
    pluck(feature).uniq.compact.map(&:humanize)
  end

  def self.find_and_sort_by_ids(personas_data)
    personas_ids = personas_data.map { |persona_data| persona_data['id'] }
    Persona.where(id: personas_ids).sort_by { |persona| personas_ids.index(persona.id) }
  end

  private

  def capitalize_attributes
    attributes.each do |attr, value|
      self[attr] = value.to_s.capitalize if value.is_a?(String) && attr != "picture"
    end
  end
end
