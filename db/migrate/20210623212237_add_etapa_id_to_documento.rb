class AddEtapaIdToDocumento < ActiveRecord::Migration[5.2]
  def change
    add_column :documentos, :etapa_id, :integer
    add_index :documentos, :etapa_id
  end
end
