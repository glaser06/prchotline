require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#



# importing county coordinators
csv_text = File.read('countyCoordinators.csv')
csv = CSV.parse(csv_text, :headers => true)

csv.each do |row|
  countyName = row["County"]
  countyCoord = row["Coordinator "]
  countyPhone = row["Phone #"]
  countyWebsite = row["Website"]
  if countyCoord == 'N/A'
    countyCoord = nil
  end
  if countyPhone == 'N/A'
    countyPhone = nil
  end
  if countyWebsite == 'N/A'
    countyWebsite = nil
  end
  County.create( name: countyName, coordinator: countyCoord, phone: countyPhone, website: countyWebsite)
end

# importing items
item_list = ["Paper", "Television"]

item_list = ["Air Conditioners", "Aluminum", "Ammunition", "Antifreeze", "Appliances (with Freon)", "Appliances (No Freon)", "Art & Education Materials", "Asbestos", "Aseptic Packaging (Drink Boxes/Milk Cartons)", "Asphalt, Brick, Concrete, Gravel, & Porcelain", "Audio/Videotapes, CDs, DVDs, & Records", "Automotive Parts & Liquids",
"Ballast", "Batteries (Alkaline/Zinc Carbon)", "Batteries (Button Cell)", "Batteries (Lead Acid)", "Batteries (Rechargable)", "Biohazardous Waste", "Books","Bricks","Building Materials","Light Bulbs",
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
"Oil Heaters",
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
  index = name
  if name.split(" ").count == 1
    index = name.singularize
  end
  @item = Item.create( name: index.downcase, description: "Nothing just yet", active: true)

  # @item.aliases.create(name: name.downcase, active: true)
  if name == "Mobile Phones"
    @item.aliases.create(name: "Cellphone".downcase, active: true)
  elsif name == "Televisions"
    @item.aliases.create(name: "TV".downcase, active: true)
  elsif name == "Light Bulbs"
    @item.aliases.create(name: "Bulb".downcase, active: true)
  end
  Rails.logger.info(@item.errors.inspect)
end




locations = {}
tmpPath = Rails.root.join("county-data")
Dir.foreach(tmpPath) do |fname|
  next if fname == '.' or fname == '..'
  # do work on real items
  path = Rails.root.join("county-data/#{fname}")
  csv_text = File.open(path, "r:ISO-8859-1")
  csv = CSV.parse(csv_text, :headers => true)


  csv.each do |row|

    if row['Location Name']
      name = row['Location Name'].strip
      if row["Item"] && row["County"]
        item = row["Item"].downcase.strip
        # puts item
        county = row['County'].strip.split(' ')[0]
        # puts county
        # puts county
        if row["Address"]
          if !locations.key?(name)
            locations[name] = {}




            locations[name]["Addr"] = [[row['City'],row["Address"], row["Location Name"], row['Phone'], row['Website'],row["Details"], county]]
            locations[name][item] = row["Details"]

          else




            locations[name]["Addr"].push([row['City'],row["Address"], row["Location Name"], row['Phone'], row['Website'],row["Details"], county])
            locations[name][item] = row["Details"]

          end
        end



      end
    else
      puts row

    end

  end
end


locations.each do |addr, items|
  row1 = items["Addr"][0]
  @loc1 = Location.new(name: row1[2], phone: row1[3], website: row1[4], active: true)
  if @loc1.nil?
    print "loc nil"
  end
  items["Addr"].each do |row|
    c = County.for_name(row[6]).first
    if c.nil?
      print "#{row[6]} nil"
    end
    flag = false
    @loc1.addresses.each do |addr_rows|
      addr1 = addr_rows.address
      # addr1 = addr_rows[1]
      if row[1].strip == addr1.strip
        flag = true
      end
    end
    if !flag
      city = ""
      address1 = ""
      unless row[0].nil?

        city = row[0].strip
      end
      unless row[1].nil?
        address1 = row[1].strip
      end
      @loc1.addresses.build(address: address1, city: city, zipcode: "", state: 'PA', county_id: c.id, location_id: @loc1.id, active: true)
    end


  end
  items.each do |item, emp|
    if item != "Addr"
      index = item
      if item.split(" ").count == 1
        index = item.singularize
      end
      i = Item.for_name(index.downcase).first
      if i.nil?
        a = Alias.for_name(index.downcase).first
        if a.nil?
          puts "#{item} is nil"
        else
          if a.item.nil?
            puts "#{item} is alias"
          end

          @loc1.item_locations.build(item_id: a.item.id, location_id: @loc1.id, context: emp ,active: true)
        end

      else
        if i.nil?
          puts "#{item} is alias"
        end
        @loc1.item_locations.build(item_id: i.id, location_id: @loc1.id, context: emp ,active: true)
      end

    end


  end
  @loc1.save



end
