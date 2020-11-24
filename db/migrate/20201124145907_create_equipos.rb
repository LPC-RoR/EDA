class CreateEquipos < ActiveRecord::Migration[5.2]
  def change
    create_table :equipos do |t|
      t.string :equipo
      t.integer :administrador_id

      t.timestamps
    end
    add_index :equipos, :equipo
    add_index :equipos, :administrador_id
  end
end
