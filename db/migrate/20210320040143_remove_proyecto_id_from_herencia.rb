class RemoveProyectoIdFromHerencia < ActiveRecord::Migration[5.2]
  def change
    remove_column :herencias, :proyecto_id, :integer
  end
end
