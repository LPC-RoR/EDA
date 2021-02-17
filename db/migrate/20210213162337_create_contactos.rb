class CreateContactos < ActiveRecord::Migration[5.2]
  def change
    create_table :contactos do |t|
      t.string :tipo
      t.string :estado
      t.string :contacto
      t.integer :perfil_id
      t.datetime :sended_at

      t.timestamps
    end
    add_index :contactos, :tipo
    add_index :contactos, :estado
    add_index :contactos, :perfil_id
    add_index :contactos, :sended_at
  end
end
