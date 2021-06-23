class CreateDocumentos < ActiveRecord::Migration[5.2]
  def change
    create_table :documentos do |t|
      t.string :documento
      t.integer :proyecto_id

      t.timestamps
    end
    add_index :documentos, :proyecto_id
  end
end
