# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
County.create(name: 'Alleghey')
County.create(name: 'Bucks')

Item.create(name: 'Paint', description: 'Paint needs to be disposed of properly to protect the environment.', active: true)
Item.create(name: 'Television', description: 'Nothing right now', active: true)
Item.create(name: 'Shredded Paper', description: 'Nothing right now', active: false)

Location.create(name: 'Best Buy', address: '123 Main Street', city: 'Lancaster', phone: '4123211234', website: 'bestbuy.com', zipcode: '15123', state: 'PA')
Location.create(name: 'Giant Eagle', address: '321 Hello Street', city: 'Pittsburgh', phone: '4123214567', website: 'gianteagle.com', zipcode: '15289', state: 'PA')