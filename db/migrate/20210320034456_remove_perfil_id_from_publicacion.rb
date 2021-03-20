class RemovePerfilIdFromPublicacion < ActiveRecord::Migration[5.2]
  def change
    remove_column :publicaciones, :perfil_id, :integer
  end
end
