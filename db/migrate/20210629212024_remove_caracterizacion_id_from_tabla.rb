class RemoveCaracterizacionIdFromTabla < ActiveRecord::Migration[5.2]
  def change
    remove_index :tablas, :caracterizacion_id
    remove_column :tablas, :caracterizacion_id, :integer
  end
end
