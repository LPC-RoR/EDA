class AddProyectoIdToEspecificacion < ActiveRecord::Migration[5.2]
  def change
    add_column :especificaciones, :proyecto_id, :integer
    add_index :especificaciones, :proyecto_id
  end
end
