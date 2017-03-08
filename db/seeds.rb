require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

county_list = ["Adams", "Allegheny", "Armstrong", "Beaver", "Bedford", "Berks", "Blair", "Bradford", "Bucks", "Butler", "Cambria", "Cameron", "Carbon", "Centre", "Chester", "Clarion", "Clearfield", "Clinton", "Columbia", "Crawford", "Cumberland", "Dauphin", "Delaware", "Elk", "Erie", "Fayette", "Forest", "Franklin", "Fulton", "Greene", "Huntingdon", "Indiana", "Jefferson", "Juniata", "Lackawanna", "Lancaster", "Lawrence", "Lebanon", "Lehigh", "Luzerne", "Lycoming", "Mckean", "Mercer", "Mifflin", "Monroe", "Montgomery", "Montour", "Northampton", "Northumberland", "Perry", "Philadelphia", "Pike", "Potter", "Schuylkill", "Snyder", "Somerset", "Sullivan", "Susquehanna", "Tioga", "Union", "Venango", "Warren", "Washington", "Wayne", "Westmoreland", "Wyoming", "York"]

county_list.each do |name|
  County.create( name: name)
end

item_list = ["Paper", "Television"]



item_list = ["Air Conditioners", "Aluminum", "Ammunition", "Antifreeze", "Appliances (with Freon)", "Appliances (No Freon)", "Art & Education Materials", "Asbestos", "Aseptic Packaging (Drink Boxes/Milk Cartons)", "Asphalt, Brick, Concrete, Gravel, & Porcelain", "Audio/Videotapes, CDs, DVDs, & Records", "Automotive Parts & Liquids",
"Ballast", "Batteries (Alkaline/Zinc Carbon)", "Batteries (Button Cell)", "Batteries (Lead Acid)", "Batteries (Rechargable)", "Biohazardous Waste", "Books","Bricks","Building Materials","Bulbs",
"Car/Vehicle Donations", "Car Seats", "Cardboard","Carpet","Cartons","Cell Phones","Christmas Lights","Christmas Trees","Clothing/Textiles","CFL Bulbs","Compost","Computers","Concrete","Construction/Demolition Materials","Cooking Oil",
"Cork",
"Couches",
"Cylinders",
"Data Destruction",
"Dehumidifier",
"Donations",
"Drugs",
"Driveway Sealer",
"Drywall",
"Electronic Equiptment",
"Eyeglasses",
"Filters",
"Fire Extinguishers",
"Fishing Lines",
"Flares",
"Fluorescent Lights",
"Foam",
"Food",
"Freon",
"Fuels/Solvents",
"Furniture",
"Glass",
"Grease",
"Greeting Cards",
"Grocery Bags",
"Hangers",
"Hazardous Waste",
"Helium Tanks",
"Humidifier",
"Ink Cartridges",
"Junk Removal",
"Junk Mail",
"Kerosene",
"Medicine",
"Mercury",
"Microwaves",
"Milk Cartons & Drink Boxes",
"Mobile Phones",
"Monofilament (Fishing Line)",
"Motor Oil",
"Needles",
"Oil",
"Packaging Peanuts",
"Paint (Oil/Solvent Base)",
"Paper",
"Paper Shredding",
"Pesticides",
"Pet Supplies",
"Phone Books",
"Phones",
"Plastic",
"Plastic Bottle Caps",
"Polystyrene",
"Pool Chemicals",
"Prom Dresses",
"Propane Tanks",
"Railroad Ties",
"Rain Barrels",
"Refrigerators",
"Scrap & Metal",
"Sharps/Syringes",
"Shoes",
"Smoke Detectors",
"Solvents",
"Sporting Goods",
"Styrofoam/Expanded Polystyrene",
"Syringes",
"Tanks",
"Telephone Books",
"Televisions",
"Thermostats",
"Tires",
"Toner/Laser Cartridges",
"Wood",
"X-Ray & MRI Film",
"Yard Waste"]
item_list.each do |name|
  Item.create( name: name, description: "Nothing just yet", active: true)
end
# Item.create(name: 'Paint', description: 'Paint needs to be disposed of properly to protect the environment.', active: true)
# Item.create(name: 'Television', description: 'Nothing right now', active: true)
# Item.create(name: 'Shredded Paper', description: 'Nothing right now', active: false)

# Location.create(name: 'Best Buy', address: '123 Main Street', city: 'Lancaster', phone: '4123211234', website: 'bestbuy.com', zipcode: '15123', state: 'PA')
# Location.create(name: 'Giant Eagle', address: '321 Hello Street', city: 'Pittsburgh', phone: '4123214567', website: 'gianteagle.com', zipcode: '15289', state: 'PA')

# i = 0
# County.all.each do |county|
#   i += 1
  # address =
#   Location.create(name: (county.name+'Recycling Facility'+i), address: '')
#
# end

csv_text = File.read('zipcodes.csv')
csv = CSV.parse(csv_text, :headers => true)
countyZip = {}
csv.each do |row|

  if row['county']
    county = row['county'].split(' ')[0]
    if countyZip.key?(county)
      countyZip[county].push([row['zip'],row['primary_city']])
    else
      countyZip[county] = [[row['zip'],row['primary_city']]]
    end
  end

end
Faker::Config.locale = 'en-US'
County.all.each do |c|
  county = c.name
  zipcodes = countyZip[county]
  if countyZip.key?(county)
    count = 1
    zipcodes.each do |zipCity|
      rand(3).times do |tmp|


        address = "#{Faker::Address.street_address} Ave."
        phone = (Faker::PhoneNumber.phone_number).split('x')[0]
        # c.locations.create(name: "#{county} Recycling Facility ##{count} in #{zipCity[1]}", address: address, city: zipCity[1], phone: phone, website: 'www.example.com', zipcode: zipCity[0], state: 'PA', counties_id: c.id, active: true)
        @loc1 = Location.create(name: "#{county} Recycling Facility ##{count} in #{zipCity[1]}", address: address, city: zipCity[1], phone: phone, website: 'www.example.com', zipcode: zipCity[0], state: 'PA', counties_id: c.id, active: true)
        # Rails.logger.info(@loc1.errors.inspect)
        count += 1
      end
    end
  end
end
# countyZip.each do |county, zipcodes|
#
# end

items = Item.all
locs = Location.all
items.each do |item|
  if ["Paper", "Televisions","Mobile Phones","Cardboard"].include?(item.name)
    locs.each do |loc|

      ItemLocation.create(item_id: item.id, location_id: loc.id, context: "This is an example context. We don't know much beyond this.",active: true)

    end
  end
end
