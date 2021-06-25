class AddTablaIdToDocumento < ActiveRecord::Migration[5.2]
  def change
    add_column :documentos, :tabla_id, :integer
    add_index :documentos, :tabla_id
  end
end
