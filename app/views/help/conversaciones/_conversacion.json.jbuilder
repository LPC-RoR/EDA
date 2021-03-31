json.extract! conversacion, :id, :parent_id, :child_id, :created_at, :updated_at
json.url conversacion_url(conversacion, format: :json)
