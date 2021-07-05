class AddPadreClassToTabla < ActiveRecord::Migration[5.2]
  def change
    add_column :tablas, :padre_class, :string
    add_index :tablas, :padre_class
  end
end
