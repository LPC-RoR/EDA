class AddColumnaToColumna < ActiveRecord::Migration[5.2]
  def change
    add_column :columnas, :columna, :string
  end
end
