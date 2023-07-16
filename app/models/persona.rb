class Persona < ApplicationRecord
  has_many :games

  before_validation :capitalize_attributes

  private

  def capitalize_attributes
    attributes.each do |attr, value|
      self[attr] = value.to_s.capitalize if value.is_a?(String)
    end
  end
end
