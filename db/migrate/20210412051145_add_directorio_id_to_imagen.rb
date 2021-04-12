class AddDirectorioIdToImagen < ActiveRecord::Migration[5.2]
  def change
    add_column :imagenes, :directorio_id, :integer
    add_index :imagenes, :directorio_id
  end
end
