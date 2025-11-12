json.extract! category, :id, :name, :super_category_id, :user_id, :created_at, :updated_at
json.url category_url(category, format: :json)
