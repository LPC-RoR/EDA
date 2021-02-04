class RemoveInvestigadorIdFromPerfil < ActiveRecord::Migration[5.2]
  def change
    remove_column :perfiles, :investigador_id, :integer
    remove_column :perfiles, :equipo_id, :integer
  end
end
