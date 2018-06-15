# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Gabriel H.', email: 'gabrielheiler@gmail.com', salt: 'saltyText', 
    password: '963efe3fb630e00d306fc4de165e7107dae371e8', language: 'es')
