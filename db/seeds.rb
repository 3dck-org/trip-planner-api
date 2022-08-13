# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: "Web app", redirect_uri: "", scopes: "")
end

Role.where(code: 'ADM', name: 'Administrator').first_or_create
Role.where(code: 'USR', name: 'User').first_or_create