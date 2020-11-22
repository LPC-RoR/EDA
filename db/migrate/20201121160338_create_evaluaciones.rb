class CreateEvaluaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluaciones do |t|
      t.integer :publicacion_id
      t.string :aspecto
      t.string :evaluacion

      t.timestamps
    end
    add_index :evaluaciones, :publicacion_id
    add_index :evaluaciones, :aspecto
  end
end
