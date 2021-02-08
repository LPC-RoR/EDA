class CreateVersiones < ActiveRecord::Migration[5.2]
  def change
    create_table :versiones do |t|
      t.string :version
      t.string :estado
      t.string :nota
      t.integer :proyecto_id

      t.timestamps
    end
    add_index :versiones, :estado
    add_index :versiones, :proyecto_id
  end
end
