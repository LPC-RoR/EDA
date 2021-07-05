class AddCaracterizacionIdToTabla < ActiveRecord::Migration[5.2]
  def change
    add_column :tablas, :caracterizacion_id, :integer
    add_index :tablas, :caracterizacion_id
  end
end
