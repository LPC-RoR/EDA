class RemovePerfilIdFromTema < ActiveRecord::Migration[5.2]
  def change
    remove_column :temas, :perfil_id, :integer
  end
end
