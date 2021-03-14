class CreateAsociaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :asociaciones do |t|
      t.integer :publicacion_id
      t.integer :proyecto_id

      t.timestamps
    end
    add_index :asociaciones, :publicacion_id
    add_index :asociaciones, :proyecto_id
  end
end
