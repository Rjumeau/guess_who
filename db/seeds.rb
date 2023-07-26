# ------ Clean Db -----
models = [Round, Game, Persona, User]

models.each do |model|
  puts "Destroy #{model}s..."
  model.delete_all
end

# ----- Add records -----
puts "Create Users..."
User.create!(email: 'romain@guesswho.com', password: 'roadtoteacher')
User.create!(email: 'test@guesswho.com', password: 'secrette')

puts "Create Personas..."
# Import and create Personas
persona_csv_file_path = Rails.root.join('db/data/persona_data.csv')
PersonaImportService.call(persona_csv_file_path)

puts "Done !"
