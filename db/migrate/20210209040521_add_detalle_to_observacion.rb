class AddDetalleToObservacion < ActiveRecord::Migration[5.2]
  def change
    add_column :observaciones, :detalle, :text
  end
end
