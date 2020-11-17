class AddIndexToRevista < ActiveRecord::Migration[5.2]
  def change
    add_index :revistas, :revista
  end
end
