class AddProyectoIdToCarpeta < ActiveRecord::Migration[5.2]
  def change
    add_column :carpetas, :proyecto_id, :integer
    add_index :carpetas, :proyecto_id
  end
end
