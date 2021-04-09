class CreateTipoPublicaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :tipo_publicaciones do |t|
      t.string :tipo_publicacion
      t.string :redireccion
      t.text :ejemplo

      t.timestamps
    end
  end
end
