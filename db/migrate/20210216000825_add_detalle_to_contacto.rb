class AddDetalleToContacto < ActiveRecord::Migration[5.2]
  def change
    add_column :contactos, :detalle, :text
  end
end
