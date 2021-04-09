class AddBibToTipoPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :tipo_publicaciones, :bib, :text
  end
end
