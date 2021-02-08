class CreateObservaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :observaciones do |t|
      t.integer :orden
      t.string :observacion
      t.integer :columna_id
      t.integer :linea_id
      t.integer :tabla_id

      t.timestamps
    end
    add_index :observaciones, :orden
    add_index :observaciones, :columna_id
    add_index :observaciones, :linea_id
    add_index :observaciones, :tabla_id
  end
end
