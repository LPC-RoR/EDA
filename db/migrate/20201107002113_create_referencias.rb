class CreateReferencias < ActiveRecord::Migration[5.2]
  def change
    create_table :referencias do |t|
      t.integer :concepto_id
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :referencias, :concepto_id
    add_index :referencias, :publicacion_id
  end
end
