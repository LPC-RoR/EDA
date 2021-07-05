class CreateCaracterizaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :caracterizaciones do |t|
      t.string :caracterizacion
      t.integer :proyecto_id

      t.timestamps
    end
    add_index :caracterizaciones, :proyecto_id
  end
end
