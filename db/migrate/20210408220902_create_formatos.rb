class CreateFormatos < ActiveRecord::Migration[5.2]
  def change
    create_table :formatos do |t|
      t.string :formato
      t.integer :perfil_id

      t.timestamps
    end
    add_index :formatos, :perfil_id
  end
end
