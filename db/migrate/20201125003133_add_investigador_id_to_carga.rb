class AddInvestigadorIdToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :investigador_id, :integer
    add_index :cargas, :investigador_id
  end
end
