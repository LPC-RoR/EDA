class AddProyectoIdToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :proyecto_id, :integer
    add_index :publicaciones, :proyecto_id
  end
end
