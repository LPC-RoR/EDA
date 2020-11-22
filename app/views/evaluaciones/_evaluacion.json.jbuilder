json.extract! evaluacion, :id, :publicacion_id, :objetivo, :resultado, :metodologia, :conclusion, :created_at, :updated_at
json.url evaluacion_url(evaluacion, format: :json)
