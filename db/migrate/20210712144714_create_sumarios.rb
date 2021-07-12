class CreateSumarios < ActiveRecord::Migration[5.2]
  def change
    create_table :sumarios do |t|
      t.string :clave
      t.integer :valor
      t.integer :encabezado_id

      t.timestamps
    end
    add_index :sumarios, :clave
    add_index :sumarios, :encabezado_id
  end
end
