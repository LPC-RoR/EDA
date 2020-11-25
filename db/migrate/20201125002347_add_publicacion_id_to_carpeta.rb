class AddPublicacionIdToCarpeta < ActiveRecord::Migration[5.2]
  def change
    add_column :carpetas, :investigador_id, :integer
    add_index :carpetas, :investigador_id
  end
end
