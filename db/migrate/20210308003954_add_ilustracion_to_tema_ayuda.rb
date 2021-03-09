class AddIlustracionToTemaAyuda < ActiveRecord::Migration[5.2]
  def change
    add_column :tema_ayudas, :ilustracion, :string
    add_column :tema_ayudas, :iustracion_cache, :string
  end
end
