class RemoveFieldsFromPublicacion < ActiveRecord::Migration[5.2]
  def change
    remove_column :publicaciones, :carga_id, :string
  end
end
