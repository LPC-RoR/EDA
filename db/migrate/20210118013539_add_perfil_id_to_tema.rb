class AddPerfilIdToTema < ActiveRecord::Migration[5.2]
  def change
    add_column :temas, :perfil_id, :integer
    add_index :temas, :perfil_id

    remove_column :temas, :investigador_id, :integer
  end
end
