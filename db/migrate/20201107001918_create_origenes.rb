class CreateOrigenes < ActiveRecord::Migration[5.2]
  def change
    create_table :origenes do |t|
      t.integer :repositorio_id
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :origenes, :repositorio_id
    add_index :origenes, :publicacion_id
  end
end
