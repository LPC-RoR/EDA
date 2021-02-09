class AddTablaIdToEncabezado < ActiveRecord::Migration[5.2]
  def change
    add_column :encabezados, :tabla_id, :integer
    add_index :encabezados, :tabla_id
  end
end
