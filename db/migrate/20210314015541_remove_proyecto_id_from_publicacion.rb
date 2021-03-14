class RemoveProyectoIdFromPublicacion < ActiveRecord::Migration[5.2]
  def change
    remove_column :publicaciones, :proyecto_id, :integer
  end
end
