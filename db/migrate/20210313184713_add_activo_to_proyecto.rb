class AddActivoToProyecto < ActiveRecord::Migration[5.2]
  def change
    add_column :proyectos, :activo, :boolean
    add_index :proyectos, :activo
  end
end
