class CreateClasificaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :clasificaciones do |t|
      t.integer :carpeta_id
      t.integer :texto_id

      t.timestamps
    end
    add_index :clasificaciones, :carpeta_id
    add_index :clasificaciones, :texto_id
  end
end
