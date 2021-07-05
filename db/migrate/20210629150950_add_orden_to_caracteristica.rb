class AddOrdenToCaracteristica < ActiveRecord::Migration[5.2]
  def change
    add_column :caracteristicas, :orden, :integer
    add_index :caracteristicas, :orden
  end
end
