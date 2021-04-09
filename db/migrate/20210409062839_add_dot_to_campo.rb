class AddDotToCampo < ActiveRecord::Migration[5.2]
  def change
    add_column :campos, :dot, :boolean
    add_index :campos, :dot
  end
end
