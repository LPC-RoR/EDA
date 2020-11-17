class RemovePublicacionIdFromTexto < ActiveRecord::Migration[5.2]
  def change
    remove_column :textos, :publicacion_id, :integer
  end
end
