class CreateEquipos < ActiveRecord::Migration[5.2]
  def change
    create_table :equipos do |t|
      t.string :equipo
      t.string :sha1, limit: 40
      t.integer :administrador_id

      t.timestamps
    end
    add_index :equipos, :equipo
    add_index :equipos, :administrador_id
    add_index :equipos, :sha1
  end
end
   
