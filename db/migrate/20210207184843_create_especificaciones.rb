class CreateEspecificaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :especificaciones do |t|
      t.integer :orden
      t.string :especificacion
      t.text :detalle
      t.integer :tabla_id
      t.integer :etapa_id

      t.timestamps
    end
    add_index :especificaciones, :orden
    add_index :especificaciones, :tabla_id
    add_index :especificaciones, :etapa_id
  end
end
