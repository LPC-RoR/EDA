class RemoveInvestigadorIdToIntegrante < ActiveRecord::Migration[5.2]
  def change
    remove_column :integrantes, :investigador_id, :integer
    add_column :integrantes, :perfil_id, :integer
    add_index :integrantes, :perfil_id
  end
end
