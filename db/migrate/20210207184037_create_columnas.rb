class CreateColumnas < ActiveRecord::Migration[5.2]
  def change
    create_table :columnas do |t|
      t.integer :orden
      t.integer :linea_id

      t.timestamps
    end
    add_index :columnas, :orden
    add_index :columnas, :linea_id
  end
end
