class AddChecksToTabla < ActiveRecord::Migration[5.2]
  def change
    add_column :tablas, :archivos, :boolean
    add_index :tablas, :archivos
    add_column :tablas, :imagenes, :boolean
    add_index :tablas, :imagenes
  end
end
