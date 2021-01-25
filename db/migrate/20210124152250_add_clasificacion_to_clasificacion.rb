class AddClasificacionToClasificacion < ActiveRecord::Migration[5.2]
  def change
    add_column :clasificaciones, :clasificacion, :string
    add_index :clasificaciones, :clasificacion
  end
end
