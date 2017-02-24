json.extract! location, :id, :name, :address, :phone, :website, :city, :zipcode, :state, :created_at, :updated_at
json.url location_url(location, format: :json)