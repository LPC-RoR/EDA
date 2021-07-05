class RemovePublicacionIdFromLinea < ActiveRecord::Migration[5.2]
  def change
    remove_index :lineas, :publicacion_id
    remove_column :lineas, :publicacion_id, :integer
  end
end
