class AddIndexToIdioma < ActiveRecord::Migration[5.2]
  def change
    add_index :idiomas, :idioma
  end
end
