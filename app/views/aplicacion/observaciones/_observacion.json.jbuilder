json.extract! observacion, :id, :orden, :observacion, :columna_id, :linea_id, :tabla_id, :created_at, :updated_at
json.url observacion_url(observacion, format: :json)
