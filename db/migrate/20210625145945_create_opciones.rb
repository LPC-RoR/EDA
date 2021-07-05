class CreateOpciones < ActiveRecord::Migration[5.2]
  def change
    create_table :opciones do |t|
      t.string :opcion
      t.integer :caracteristica_id

      t.timestamps
    end
    add_index :opciones, :caracteristica_id
  end
end
