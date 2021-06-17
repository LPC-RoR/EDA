class CreateReportes < ActiveRecord::Migration[5.2]
  def change
    create_table :reportes do |t|
      t.string :reporte
      t.integer :proyecto_id

      t.timestamps
    end
    add_index :reportes, :proyecto_id
  end
end
