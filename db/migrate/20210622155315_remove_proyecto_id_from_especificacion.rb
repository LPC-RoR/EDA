class RemoveProyectoIdFromEspecificacion < ActiveRecord::Migration[5.2]
  def change
    remove_column :especificaciones, :proyecto_id, :integer
  end
end
