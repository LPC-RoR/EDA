class CreateHerencias < ActiveRecord::Migration[5.2]
  def change
    create_table :herencias do |t|
      t.integer :tema_id
      t.integer :proyecto_id

      t.timestamps
    end
    add_index :herencias, :tema_id
    add_index :herencias, :proyecto_id
  end
end
