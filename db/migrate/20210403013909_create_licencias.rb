class CreateLicencias < ActiveRecord::Migration[5.2]
  def change
    create_table :licencias do |t|
      t.string :n_meses
      t.integer :perfil_id

      t.timestamps
    end
    add_index :licencias, :perfil_id
  end
end
