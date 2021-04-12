class AddDirectorioIdToArchivo < ActiveRecord::Migration[5.2]
  def change
    add_column :archivos, :directorio_id, :integer
    add_index :archivos, :directorio_id
  end
end
