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

item_list.each do |name|
  Item.create( name: name, description: "Nothing just yet", active: true)
end

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

# Item.create(name: 'Paint', description: 'Paint needs to be disposed of properly to protect the environment.', active: true)
# Item.create(name: 'Television', description: 'Nothing right now', active: true)
# Item.create(name: 'Shredded Paper', description: 'Nothing right now', active: false)

Location.create(name: 'Best Buy', address: '123 Main Street', city: 'Lancaster', phone: '4123211234', website: 'bestbuy.com', zipcode: '15123', state: 'PA')
Location.create(name: 'Giant Eagle', address: '321 Hello Street', city: 'Pittsburgh', phone: '4123214567', website: 'gianteagle.com', zipcode: '15289', state: 'PA')