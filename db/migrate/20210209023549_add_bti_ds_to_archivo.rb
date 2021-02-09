class AddBtiDsToArchivo < ActiveRecord::Migration[5.2]
  def change
    add_column :archivos, :linea_id, :integer
    add_index :archivos, :linea_id
    add_column :archivos, :columna_id, :integer
    add_index :archivos, :columna_id
  end
end
