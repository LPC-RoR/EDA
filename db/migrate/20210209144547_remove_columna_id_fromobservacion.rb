class RemoveColumnaIdFromobservacion < ActiveRecord::Migration[5.2]
  def change
    remove_column :observaciones, :columna_id, :integer
  end
end
