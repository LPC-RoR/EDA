class CreateMetodologias < ActiveRecord::Migration[5.2]
  def change
    create_table :metodologias do |t|
      t.string :metodologia
      t.integer :orden
      t.integer :publicacion_id

      t.timestamps
    end
    add_index :metodologias, :orden
    add_index :metodologias, :publicacion_id
  end
end
