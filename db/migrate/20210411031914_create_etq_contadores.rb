class CreateEtqContadores < ActiveRecord::Migration[5.2]
  def change
    create_table :etq_contadores do |t|
      t.integer :etiqueta_id
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :etq_contadores, :etiqueta_id
    add_index :etq_contadores, :publicacion_id
  end
end
