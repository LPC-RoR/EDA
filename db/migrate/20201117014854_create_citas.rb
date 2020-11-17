class CreateCitas < ActiveRecord::Migration[5.2]
  def change
    create_table :citas do |t|
      t.integer :publicacion_id
      t.integer :texto_id

      t.timestamps
    end
    add_index :citas, :publicacion_id
    add_index :citas, :texto_id
  end
end
