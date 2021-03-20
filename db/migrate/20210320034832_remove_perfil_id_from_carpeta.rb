class RemovePerfilIdFromCarpeta < ActiveRecord::Migration[5.2]
  def change
    remove_column :carpetas, :perfil_id, :integer
  end
end
