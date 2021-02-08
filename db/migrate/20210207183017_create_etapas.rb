class CreateEtapas < ActiveRecord::Migration[5.2]
  def change
    create_table :etapas do |t|
      t.integer :orden
      t.string :etapa
      t.integer :proyecto_id

      t.timestamps
    end
    add_index :etapas, :orden
    add_index :etapas, :proyecto_id
  end
end
