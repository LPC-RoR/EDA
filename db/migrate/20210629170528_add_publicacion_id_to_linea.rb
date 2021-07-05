class AddPublicacionIdToLinea < ActiveRecord::Migration[5.2]
  def change
    add_column :lineas, :publicacion_id, :integer
    add_index :lineas, :publicacion_id
  end
end
