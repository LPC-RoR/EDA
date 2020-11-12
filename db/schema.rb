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

ActiveRecord::Schema.define(version: 2020_11_10_212352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agregaciones", force: :cascade do |t|
    t.integer "categoria_id"
    t.integer "concepto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categoria_id"], name: "index_agregaciones_on_categoria_id"
    t.index ["concepto_id"], name: "index_agregaciones_on_concepto_id"
  end

  create_table "autores", force: :cascade do |t|
    t.integer "publicacion_id"
    t.integer "investigador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investigador_id"], name: "index_autores_on_investigador_id"
    t.index ["publicacion_id"], name: "index_autores_on_publicacion_id"
  end

  create_table "conceptos", force: :cascade do |t|
    t.string "concepto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concepto"], name: "index_conceptos_on_concepto"
  end

  create_table "departamentos", force: :cascade do |t|
    t.string "departamento"
    t.integer "institucion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institucion_id"], name: "index_departamentos_on_institucion_id"
  end

  create_table "idiomas", force: :cascade do |t|
    t.string "idioma"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instituciones", force: :cascade do |t|
    t.string "institucion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "metodologias", force: :cascade do |t|
    t.string "metodologia"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publicacion_id"], name: "index_metodologias_on_publicacion_id"
  end

  create_table "origenes", force: :cascade do |t|
    t.integer "repositorio_id"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publicacion_id"], name: "index_origenes_on_publicacion_id"
    t.index ["repositorio_id"], name: "index_origenes_on_repositorio_id"
  end

  create_table "publicaciones", force: :cascade do |t|
    t.string "titulo"
    t.integer "annio"
    t.string "paginas"
    t.string "link"
    t.string "abstract"
    t.integer "registro_id"
    t.integer "revista_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "detalle_autores"
    t.string "detalle_revista"
    t.text "keywords"
    t.text "detalle_instituciones"
    t.text "fechas"
    t.string "doi"
    t.index ["registro_id"], name: "index_publicaciones_on_registro_id"
    t.index ["revista_id"], name: "index_publicaciones_on_revista_id"
  end

  create_table "referencias", force: :cascade do |t|
    t.integer "concepto_id"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concepto_id"], name: "index_referencias_on_concepto_id"
    t.index ["publicacion_id"], name: "index_referencias_on_publicacion_id"
  end

  create_table "registros", force: :cascade do |t|
    t.string "doi"
    t.integer "institucion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doi"], name: "index_registros_on_doi"
    t.index ["institucion_id"], name: "index_registros_on_institucion_id"
  end

  create_table "repositorios", force: :cascade do |t|
    t.string "repositorio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "revistas", force: :cascade do |t|
    t.string "revista"
    t.integer "idioma_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idioma_id"], name: "index_revistas_on_idioma_id"
  end

  create_table "textos", force: :cascade do |t|
    t.string "texto"
    t.string "calificacion"
    t.string "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

end
