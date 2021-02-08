class AddArchivoToTabla < ActiveRecord::Migration[5.2]
  def change
    add_column :tablas, :archivo, :string
  end
end
