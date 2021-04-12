class CreateDirectorios < ActiveRecord::Migration[5.2]
  def change
    create_table :directorios do |t|
      t.string :directorio
      t.integer :proyecto_id

      t.timestamps
    end
    add_index :directorios, :proyecto_id
  end
end
