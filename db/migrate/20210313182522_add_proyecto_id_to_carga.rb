class AddProyectoIdToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :proyecto_id, :integer
    add_index :cargas, :proyecto_id
  end
end
