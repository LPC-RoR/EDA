class AddPfieldsToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :detalle_autores, :string
    add_column :publicaciones, :detalle_revista, :string
    add_column :publicaciones, :keywords, :text
    add_column :publicaciones, :detalle_instituciones, :text
    add_column :publicaciones, :fechas, :text
    add_column :publicaciones, :doi, :string
  end
end
