class CreateProyectos < ActiveRecord::Migration[5.2]
  def change
    create_table :proyectos do |t|
      t.string :proyecto
      t.string :sha1
      t.integer :administrador_id

      t.timestamps
    end
    add_index :proyectos, :proyecto
    add_index :proyectos, :sha1
    add_index :proyectos, :administrador_id
  end
end
