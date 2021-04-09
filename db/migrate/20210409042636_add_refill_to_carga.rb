class AddRefillToCarga < ActiveRecord::Migration[5.2]
  def change
    add_column :cargas, :refill, :boolean
  end
end
