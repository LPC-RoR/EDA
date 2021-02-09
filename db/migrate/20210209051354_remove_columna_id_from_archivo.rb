class RemoveColumnaIdFromArchivo < ActiveRecord::Migration[5.2]
  def change
    remove_column :archivos, :columna_id, :integer
  end
end
