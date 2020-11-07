json.extract! publicacion, :id, :titulo, :annio, :paginas, :link, :abstract, :registro_id, :revista_id, :created_at, :updated_at
json.url publicacion_url(publicacion, format: :json)
