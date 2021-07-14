class CreateCampoCargas < ActiveRecord::Migration[5.2]
  def change
    create_table :campo_cargas do |t|
      t.string :campo_carga
      t.string :campo_tabla
      t.integer :formato_carga_id

      t.timestamps
    end
    add_index :campo_cargas, :campo_carga
    add_index :campo_cargas, :campo_tabla
    add_index :campo_cargas, :formato_carga_id
  end
end
