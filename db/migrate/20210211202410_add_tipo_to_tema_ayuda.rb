class AddTipoToTemaAyuda < ActiveRecord::Migration[5.2]
  def change
    add_column :tema_ayudas, :tipo, :string
    add_index :tema_ayudas, :tipo
  end
end
