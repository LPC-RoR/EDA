class AddReferenciaToLinea < ActiveRecord::Migration[5.2]
  def change
    add_column :lineas, :referencia_id, :integer
    add_index :lineas, :referencia_id
    add_column :lineas, :referencia_class, :string
    add_index :lineas, :referencia_class
  end
end
