class CreateTextos < ActiveRecord::Migration[5.2]
  def change
    create_table :textos do |t|
      t.string :texto
      t.string :calificacion

      t.timestamps
    end
  end
end
