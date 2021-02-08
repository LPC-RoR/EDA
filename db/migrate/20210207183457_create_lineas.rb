class CreateLineas < ActiveRecord::Migration[5.2]
  def change
    create_table :lineas do |t|
      t.integer :orden
      t.integer :tabla_id
      t.string :linea

      t.timestamps
    end
    add_index :lineas, :orden
    add_index :lineas, :tabla_id
  end
end
