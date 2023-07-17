class PersonaImportService < ApplicationService
  require 'csv'

  def initialize(persona_csv_file_path)
    @persona_csv_file_path = persona_csv_file_path
  end

  def call
    import_personas
  end

  private

  def import_personas
    CSV.foreach(@persona_csv_file_path, headers: true, col_sep: ';', header_converters: :symbol) do |row|
      create_personnas(row)
    end
  end

  def create_personnas(row)
    Persona.create!(
      name: row[:name],
      picture: row[:url],
      gender: row[:gender],
      hat_color: row[:hat_color],
      hair_color: row[:hair_color],
      eyes: row[:eyes],
      nose: row[:nose],
      mustache: row[:mustache],
      beard: row[:beard],
      face_shape: row[:face_shape],
      glasses: row[:glasses],
      earrings: row[:earrings],
      face_color: row[:face_color]
    )
  end
end
