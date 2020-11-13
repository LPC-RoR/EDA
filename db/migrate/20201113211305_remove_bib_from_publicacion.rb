class RemoveBibFromPublicacion < ActiveRecord::Migration[5.2]
  def change
    remove_column :publicaciones, :titulo, :string
    remove_column :publicaciones, :annio, :integer
    remove_column :publicaciones, :paginas, :string
    remove_column :publicaciones, :detalle_autores, :string
    remove_column :publicaciones, :detalle_revista, :string
    remove_column :publicaciones, :detalle_instituciones, :string
    remove_column :publicaciones, :fechas, :text
  end
end
