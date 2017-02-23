json.extract! item, :id, :name, :description, :active, :created_at, :updated_at
json.url item_url(item, format: :json)