class Persona < ApplicationRecord
  has_many :games

  before_validation :capitalize_attributes

  def self.sample_computer_persona(user_persona)
    all.reject { |persona| persona == user_persona }.sample
  end

  private

  def capitalize_attributes
    attributes.each do |attr, value|
      self[attr] = value.to_s.capitalize if value.is_a?(String) && attr != "picture"
    end
  end
end
