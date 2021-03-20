class AddCarpetaIdToHerencia < ActiveRecord::Migration[5.2]
  def change
    add_column :herencias, :carpeta_id, :integer
    add_index :herencias, :carpeta_id
  end
end
