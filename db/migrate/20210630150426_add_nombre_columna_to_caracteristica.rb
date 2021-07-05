class AddNombreColumnaToCaracteristica < ActiveRecord::Migration[5.2]
  def change
    add_column :caracteristicas, :nombre_columna, :string
  end
end
