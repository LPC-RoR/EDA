# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_30_200630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administradores", force: :cascade do |t|
    t.string "administrador"
    t.string "email"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administradores_on_email"
    t.index ["usuario_id"], name: "index_administradores_on_usuario_id"
  end

  create_table "alcances", force: :cascade do |t|
    t.integer "reporte_id"
    t.integer "carpeta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpeta_id"], name: "index_alcances_on_carpeta_id"
    t.index ["reporte_id"], name: "index_alcances_on_reporte_id"
  end

  create_table "archivos", force: :cascade do |t|
    t.integer "orden"
    t.string "archivo"
    t.string "nota"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "linea_id"
    t.integer "directorio_id"
    t.integer "documento_id"
    t.index ["directorio_id"], name: "index_archivos_on_directorio_id"
    t.index ["documento_id"], name: "index_archivos_on_documento_id"
    t.index ["linea_id"], name: "index_archivos_on_linea_id"
    t.index ["orden"], name: "index_archivos_on_orden"
  end

  create_table "asociaciones", force: :cascade do |t|
    t.integer "publicacion_id"
    t.integer "proyecto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_asociaciones_on_proyecto_id"
    t.index ["publicacion_id"], name: "index_asociaciones_on_publicacion_id"
  end

  create_table "autores", force: :cascade do |t|
    t.integer "publicacion_id"
    t.integer "investigador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investigador_id"], name: "index_autores_on_investigador_id"
    t.index ["publicacion_id"], name: "index_autores_on_publicacion_id"
  end

  create_table "campos", force: :cascade do |t|
    t.string "campo"
    t.integer "orden"
    t.boolean "cursiva"
    t.boolean "negrita"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tipo_publicacion_id"
    t.integer "formato_id"
    t.boolean "dot"
    t.index ["cursiva"], name: "index_campos_on_cursiva"
    t.index ["dot"], name: "index_campos_on_dot"
    t.index ["formato_id"], name: "index_campos_on_formato_id"
    t.index ["negrita"], name: "index_campos_on_negrita"
    t.index ["orden"], name: "index_campos_on_orden"
    t.index ["tipo_publicacion_id"], name: "index_campos_on_tipo_publicacion_id"
  end

  create_table "caracteristicas", force: :cascade do |t|
    t.string "caracteristica"
    t.string "tipo"
    t.integer "caracterizacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "orden"
    t.string "nombre_columna"
    t.index ["caracterizacion_id"], name: "index_caracteristicas_on_caracterizacion_id"
    t.index ["orden"], name: "index_caracteristicas_on_orden"
  end

  create_table "caracterizaciones", force: :cascade do |t|
    t.string "caracterizacion"
    t.integer "proyecto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_caracterizaciones_on_proyecto_id"
  end

  create_table "cargas", force: :cascade do |t|
    t.string "archivo"
    t.string "nota"
    t.string "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "n_procesados"
    t.integer "n_nuevos"
    t.integer "n_duplicados"
    t.integer "n_vinculados"
    t.integer "n_existentes"
    t.string "archivo_carga"
    t.integer "proyecto_id"
    t.boolean "refill"
    t.index ["proyecto_id"], name: "index_cargas_on_proyecto_id"
  end

  create_table "carpetas", force: :cascade do |t|
    t.string "carpeta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "proyecto_id"
    t.index ["carpeta"], name: "index_carpetas_on_carpeta"
    t.index ["proyecto_id"], name: "index_carpetas_on_proyecto_id"
  end

  create_table "citas", force: :cascade do |t|
    t.integer "publicacion_id"
    t.integer "texto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publicacion_id"], name: "index_citas_on_publicacion_id"
    t.index ["texto_id"], name: "index_citas_on_texto_id"
  end

  create_table "clasificaciones", force: :cascade do |t|
    t.integer "carpeta_id"
    t.integer "texto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "publicacion_id"
    t.integer "tema_id"
    t.string "clasificacion"
    t.index ["carpeta_id"], name: "index_clasificaciones_on_carpeta_id"
    t.index ["clasificacion"], name: "index_clasificaciones_on_clasificacion"
    t.index ["publicacion_id"], name: "index_clasificaciones_on_publicacion_id"
    t.index ["tema_id"], name: "index_clasificaciones_on_tema_id"
    t.index ["texto_id"], name: "index_clasificaciones_on_texto_id"
  end

  create_table "coautores", force: :cascade do |t|
    t.integer "proyecto_id"
    t.integer "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfil_id"], name: "index_coautores_on_perfil_id"
    t.index ["proyecto_id"], name: "index_coautores_on_proyecto_id"
  end

  create_table "columnas", force: :cascade do |t|
    t.integer "orden"
    t.integer "linea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "columna"
    t.index ["linea_id"], name: "index_columnas_on_linea_id"
    t.index ["orden"], name: "index_columnas_on_orden"
  end

  create_table "contactos", force: :cascade do |t|
    t.string "tipo"
    t.string "estado"
    t.string "contacto"
    t.integer "perfil_id"
    t.datetime "sended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.text "detalle"
    t.index ["estado"], name: "index_contactos_on_estado"
    t.index ["perfil_id"], name: "index_contactos_on_perfil_id"
    t.index ["sended_at"], name: "index_contactos_on_sended_at"
    t.index ["tipo"], name: "index_contactos_on_tipo"
  end

  create_table "departamentos", force: :cascade do |t|
    t.string "departamento"
    t.integer "institucion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institucion_id"], name: "index_departamentos_on_institucion_id"
  end

  create_table "directorios", force: :cascade do |t|
    t.string "directorio"
    t.integer "proyecto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_directorios_on_proyecto_id"
  end

  create_table "documentos", force: :cascade do |t|
    t.string "documento"
    t.integer "proyecto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "etapa_id"
    t.integer "tabla_id"
    t.index ["etapa_id"], name: "index_documentos_on_etapa_id"
    t.index ["proyecto_id"], name: "index_documentos_on_proyecto_id"
    t.index ["tabla_id"], name: "index_documentos_on_tabla_id"
  end

  create_table "encabezados", force: :cascade do |t|
    t.integer "orden"
    t.string "encabezado"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tabla_id"
    t.index ["orden"], name: "index_encabezados_on_orden"
    t.index ["tabla_id"], name: "index_encabezados_on_tabla_id"
  end

  create_table "equipos", force: :cascade do |t|
    t.string "equipo"
    t.string "sha1", limit: 40
    t.integer "administrador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrador_id"], name: "index_equipos_on_administrador_id"
    t.index ["equipo"], name: "index_equipos_on_equipo"
    t.index ["sha1"], name: "index_equipos_on_sha1"
  end

  create_table "especificaciones", force: :cascade do |t|
    t.integer "orden"
    t.string "especificacion"
    t.text "detalle"
    t.integer "tabla_id"
    t.integer "etapa_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["etapa_id"], name: "index_especificaciones_on_etapa_id"
    t.index ["orden"], name: "index_especificaciones_on_orden"
    t.index ["tabla_id"], name: "index_especificaciones_on_tabla_id"
  end

  create_table "etapas", force: :cascade do |t|
    t.integer "orden"
    t.string "etapa"
    t.integer "proyecto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orden"], name: "index_etapas_on_orden"
    t.index ["proyecto_id"], name: "index_etapas_on_proyecto_id"
  end

  create_table "etiquetas", force: :cascade do |t|
    t.string "etiqueta"
    t.integer "proyecto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_etiquetas_on_proyecto_id"
  end

  create_table "etq_contadores", force: :cascade do |t|
    t.integer "etiqueta_id"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["etiqueta_id"], name: "index_etq_contadores_on_etiqueta_id"
    t.index ["publicacion_id"], name: "index_etq_contadores_on_publicacion_id"
  end

  create_table "evaluaciones", force: :cascade do |t|
    t.integer "publicacion_id"
    t.string "aspecto"
    t.string "evaluacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perfil_id"
    t.index ["aspecto"], name: "index_evaluaciones_on_aspecto"
    t.index ["perfil_id"], name: "index_evaluaciones_on_perfil_id"
    t.index ["publicacion_id"], name: "index_evaluaciones_on_publicacion_id"
  end

  create_table "formatos", force: :cascade do |t|
    t.string "formato"
    t.integer "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfil_id"], name: "index_formatos_on_perfil_id"
  end

  create_table "herencias", force: :cascade do |t|
    t.integer "tema_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carpeta_id"
    t.index ["carpeta_id"], name: "index_herencias_on_carpeta_id"
    t.index ["tema_id"], name: "index_herencias_on_tema_id"
  end

  create_table "idiomas", force: :cascade do |t|
    t.string "idioma"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idioma"], name: "index_idiomas_on_idioma"
  end

  create_table "imagenes", force: :cascade do |t|
    t.integer "orden"
    t.string "imagen"
    t.string "nota"
    t.integer "linea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "directorio_id"
    t.index ["directorio_id"], name: "index_imagenes_on_directorio_id"
    t.index ["linea_id"], name: "index_imagenes_on_linea_id"
    t.index ["orden"], name: "index_imagenes_on_orden"
  end

  create_table "instituciones", force: :cascade do |t|
    t.string "institucion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "integrantes", force: :cascade do |t|
    t.integer "equipo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perfil_id"
    t.index ["equipo_id"], name: "index_integrantes_on_equipo_id"
    t.index ["perfil_id"], name: "index_integrantes_on_perfil_id"
  end

  create_table "investigadores", force: :cascade do |t|
    t.string "investigador"
    t.string "orcid"
    t.string "email"
    t.integer "departamento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departamento_id"], name: "index_investigadores_on_departamento_id"
    t.index ["investigador"], name: "index_investigadores_on_investigador"
  end

  create_table "licencias", force: :cascade do |t|
    t.string "n_meses"
    t.integer "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfil_id"], name: "index_licencias_on_perfil_id"
  end

  create_table "lineas", force: :cascade do |t|
    t.integer "orden"
    t.integer "tabla_id"
    t.string "linea"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "referencia_id"
    t.string "referencia_class"
    t.index ["orden"], name: "index_lineas_on_orden"
    t.index ["referencia_class"], name: "index_lineas_on_referencia_class"
    t.index ["referencia_id"], name: "index_lineas_on_referencia_id"
    t.index ["tabla_id"], name: "index_lineas_on_tabla_id"
  end

  create_table "mensajes", force: :cascade do |t|
    t.string "mensaje"
    t.string "tipo"
    t.string "estado"
    t.string "email"
    t.datetime "fecha_envio"
    t.text "detalle"
    t.integer "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mensajes_on_email"
    t.index ["estado"], name: "index_mensajes_on_estado"
    t.index ["fecha_envio"], name: "index_mensajes_on_fecha_envio"
    t.index ["perfil_id"], name: "index_mensajes_on_perfil_id"
    t.index ["tipo"], name: "index_mensajes_on_tipo"
  end

  create_table "metodologias", force: :cascade do |t|
    t.string "metodologia"
    t.integer "orden"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orden"], name: "index_metodologias_on_orden"
    t.index ["publicacion_id"], name: "index_metodologias_on_publicacion_id"
  end

  create_table "observaciones", force: :cascade do |t|
    t.integer "orden"
    t.string "observacion"
    t.integer "linea_id"
    t.integer "tabla_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "detalle"
    t.index ["linea_id"], name: "index_observaciones_on_linea_id"
    t.index ["orden"], name: "index_observaciones_on_orden"
    t.index ["tabla_id"], name: "index_observaciones_on_tabla_id"
  end

  create_table "opciones", force: :cascade do |t|
    t.string "opcion"
    t.integer "caracteristica_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caracteristica_id"], name: "index_opciones_on_caracteristica_id"
  end

  create_table "pasos", force: :cascade do |t|
    t.integer "orden"
    t.string "paso"
    t.text "detalle"
    t.integer "tutorial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orden"], name: "index_pasos_on_orden"
    t.index ["tutorial_id"], name: "index_pasos_on_tutorial_id"
  end

  create_table "perfiles", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "administrador_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrador_id"], name: "index_perfiles_on_administrador_id"
    t.index ["email"], name: "index_perfiles_on_email"
    t.index ["usuario_id"], name: "index_perfiles_on_usuario_id"
  end

  create_table "procesos", force: :cascade do |t|
    t.integer "carga_id"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carga_id"], name: "index_procesos_on_carga_id"
    t.index ["publicacion_id"], name: "index_procesos_on_publicacion_id"
  end

  create_table "proyectos", force: :cascade do |t|
    t.string "proyecto"
    t.string "sha1"
    t.integer "administrador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "activo"
    t.index ["activo"], name: "index_proyectos_on_activo"
    t.index ["administrador_id"], name: "index_proyectos_on_administrador_id"
    t.index ["proyecto"], name: "index_proyectos_on_proyecto"
    t.index ["sha1"], name: "index_proyectos_on_sha1"
  end

  create_table "publicaciones", force: :cascade do |t|
    t.string "link"
    t.string "abstract"
    t.integer "registro_id"
    t.integer "revista_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "keywords"
    t.string "doi"
    t.string "ingreso"
    t.string "author"
    t.string "title"
    t.string "year"
    t.string "volume"
    t.string "month"
    t.string "publisher"
    t.string "address"
    t.string "type"
    t.string "affiliation"
    t.string "article_number"
    t.string "issn"
    t.string "eissn"
    t.string "keywords_plus"
    t.string "research_areas"
    t.string "web_of_science_categories"
    t.string "author_email"
    t.string "unique_id"
    t.string "da"
    t.string "d_journal"
    t.string "d_author"
    t.string "d_doi"
    t.string "origen"
    t.string "pages"
    t.string "d_quote"
    t.string "estado"
    t.string "academic_degree"
    t.string "book"
    t.string "editor"
    t.string "ciudad_pais"
    t.string "t_sha1"
    t.string "unicidad"
    t.string "journal"
    t.string "doc_type"
    t.string "booktitle"
    t.string "series"
    t.string "number"
    t.string "note"
    t.string "meeting"
    t.index ["doc_type"], name: "index_publicaciones_on_doc_type"
    t.index ["estado"], name: "index_publicaciones_on_estado"
    t.index ["origen"], name: "index_publicaciones_on_origen"
    t.index ["registro_id"], name: "index_publicaciones_on_registro_id"
    t.index ["revista_id"], name: "index_publicaciones_on_revista_id"
    t.index ["t_sha1"], name: "index_publicaciones_on_t_sha1"
    t.index ["title"], name: "index_publicaciones_on_title"
    t.index ["unique_id"], name: "index_publicaciones_on_unique_id"
  end

  create_table "registros", force: :cascade do |t|
    t.string "doi"
    t.integer "institucion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doi"], name: "index_registros_on_doi"
    t.index ["institucion_id"], name: "index_registros_on_institucion_id"
  end

  create_table "relaciones", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_relaciones_on_child_id"
    t.index ["parent_id"], name: "index_relaciones_on_parent_id"
  end

  create_table "reportes", force: :cascade do |t|
    t.string "reporte"
    t.integer "proyecto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_reportes_on_proyecto_id"
  end

  create_table "revistas", force: :cascade do |t|
    t.string "revista"
    t.integer "idioma_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idioma_id"], name: "index_revistas_on_idioma_id"
    t.index ["revista"], name: "index_revistas_on_revista"
  end

  create_table "subs", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_subs_on_child_id"
    t.index ["parent_id"], name: "index_subs_on_parent_id"
  end

  create_table "tablas", force: :cascade do |t|
    t.integer "orden"
    t.string "tabla"
    t.integer "padre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "archivo"
    t.boolean "archivos"
    t.boolean "imagenes"
    t.string "padre_class"
    t.index ["archivos"], name: "index_tablas_on_archivos"
    t.index ["imagenes"], name: "index_tablas_on_imagenes"
    t.index ["orden"], name: "index_tablas_on_orden"
    t.index ["padre_class"], name: "index_tablas_on_padre_class"
    t.index ["padre_id"], name: "index_tablas_on_padre_id"
  end

  create_table "tema_ayudas", force: :cascade do |t|
    t.integer "orden"
    t.string "tema_ayuda"
    t.text "detalle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tipo"
    t.string "ilustracion"
    t.string "iustracion_cache"
    t.boolean "activo"
    t.index ["activo"], name: "index_tema_ayudas_on_activo"
    t.index ["orden"], name: "index_tema_ayudas_on_orden"
    t.index ["tipo"], name: "index_tema_ayudas_on_tipo"
  end

  create_table "temas", force: :cascade do |t|
    t.string "tema"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tema"], name: "index_temas_on_tema"
  end

  create_table "textos", force: :cascade do |t|
    t.string "texto"
    t.string "calificacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sha1", limit: 40
    t.index ["sha1"], name: "index_textos_on_sha1"
  end

  create_table "tipo_publicaciones", force: :cascade do |t|
    t.string "tipo_publicacion"
    t.string "redireccion"
    t.text "ejemplo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "bib"
  end

  create_table "tutoriales", force: :cascade do |t|
    t.integer "orden"
    t.string "tutorial"
    t.text "detalle"
    t.integer "tema_ayuda_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orden"], name: "index_tutoriales_on_orden"
    t.index ["tema_ayuda_id"], name: "index_tutoriales_on_tema_ayuda_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  create_table "valores", force: :cascade do |t|
    t.string "tipo"
    t.string "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tipo"], name: "index_valores_on_tipo"
  end

  create_table "versiones", force: :cascade do |t|
    t.string "version"
    t.string "estado"
    t.string "nota"
    t.integer "proyecto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado"], name: "index_versiones_on_estado"
    t.index ["proyecto_id"], name: "index_versiones_on_proyecto_id"
  end

end
