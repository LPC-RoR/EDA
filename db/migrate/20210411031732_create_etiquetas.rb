class CreateEtiquetas < ActiveRecord::Migration[5.2]
  def change
    create_table :etiquetas do |t|
      t.string :etiqueta
      t.integer :proyecto_id

      t.timestamps
    end
    add_index :etiquetas, :proyecto_id
  end
end
