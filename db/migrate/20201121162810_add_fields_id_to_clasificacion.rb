class AddFieldsIdToClasificacion < ActiveRecord::Migration[5.2]
  def change
    add_column :clasificaciones, :publicacion_id, :integer
    add_index :clasificaciones, :publicacion_id
    add_column :clasificaciones, :tema_id, :integer
    add_index :clasificaciones, :tema_id
  end
end
