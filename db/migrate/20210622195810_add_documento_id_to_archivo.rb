class AddDocumentoIdToArchivo < ActiveRecord::Migration[5.2]
  def change
    add_column :archivos, :documento_id, :integer
    add_index :archivos, :documento_id
  end
end
