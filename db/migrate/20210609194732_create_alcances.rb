class CreateAlcances < ActiveRecord::Migration[5.2]
  def change
    create_table :alcances do |t|
      t.integer :reporte_id
      t.integer :carpeta_id

      t.timestamps
    end
    add_index :alcances, :reporte_id
    add_index :alcances, :carpeta_id
  end
end
