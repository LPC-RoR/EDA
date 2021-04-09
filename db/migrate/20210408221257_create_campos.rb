class CreateCampos < ActiveRecord::Migration[5.2]
  def change
    create_table :campos do |t|
      t.string :campo
      t.integer :orden
      t.boolean :cursiva
      t.boolean :negrita

      t.timestamps
    end
    add_index :campos, :orden
    add_index :campos, :cursiva
    add_index :campos, :negrita
  end
end
