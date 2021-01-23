class AddFieldsToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :perfil_id, :integer
    add_index :cargas, :perfil_id
    add_column :cargas, :status, :string
    add_column :cargas, :n_procesados, :integer
    add_column :cargas, :n_nuevos, :integer
    add_column :cargas, :n_duplicados, :integer
    add_column :cargas, :n_vinculados, :integer
    add_column :cargas, :n_existentes, :integer

    remove_column :cargas, :investigador_id, :integer
  end
end
