class AddPublicacionIdToCarpeta < ActiveRecord::Migration[5.2]
  def change
    add_column :carpetas, :investigador_id, :integer
    add_column :carpetas, :equipo_id, :integer
    add_index :carpetas, :investigador_id
    add_index :carpetas, :equipo_id
    add_index :carpetas, :carpeta
  end
end
