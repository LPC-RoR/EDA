class CreateEncabezados < ActiveRecord::Migration[5.2]
  def change
    create_table :encabezados do |t|
      t.integer :orden
      t.string :encabezado
      t.string :tipo

      t.timestamps
    end
    add_index :encabezados, :orden
  end
end
