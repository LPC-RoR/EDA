class RemovePerfilIdFromCarga < ActiveRecord::Migration[5.2]
  def change
    remove_column :cargas, :perfil_id, :integer
  end
end
