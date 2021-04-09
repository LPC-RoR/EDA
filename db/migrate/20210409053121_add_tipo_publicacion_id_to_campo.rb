class AddTipoPublicacionIdToCampo < ActiveRecord::Migration[5.2]
  def change
    add_column :campos, :tipo_publicacion_id, :integer
    add_index :campos, :tipo_publicacion_id
    add_column :campos, :formato_id, :integer
    add_index :campos, :formato_id
  end
end
