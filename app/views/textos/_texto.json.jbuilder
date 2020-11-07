json.extract! texto, :id, :texto, :calificacion, :publicacion_id, :created_at, :updated_at
json.url texto_url(texto, format: :json)
