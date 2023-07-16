# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Delete Users..."
User.destroy_all

puts "Delete Personas..."
Persona.destroy_all

puts "Create Personas..."
# Import and create Personas
persona_csv_file_path = Rails.root.join('db/data/persona_data.csv')
PersonaImportService.call(persona_csv_file_path)

puts "Done !"
