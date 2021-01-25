class CreateCoautores < ActiveRecord::Migration[5.2]
  def change
    create_table :coautores do |t|
      t.integer :proyecto_id
      t.integer :perfil_id

      t.timestamps
    end
    add_index :coautores, :proyecto_id
    add_index :coautores, :perfil_id
  end
end
