class CreateCaracteristicas < ActiveRecord::Migration[5.2]
  def change
    create_table :caracteristicas do |t|
      t.string :caracteristica
      t.string :tipo
      t.integer :caracterizacion_id

      t.timestamps
    end
    add_index :caracteristicas, :caracterizacion_id
  end
end
