json.extract! item_location, :id, :description, :verified, :context, :created_at, :updated_at
json.url item_location_url(item_location, format: :json)