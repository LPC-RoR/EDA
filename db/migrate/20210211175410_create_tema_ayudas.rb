class CreateTemaAyudas < ActiveRecord::Migration[5.2]
  def change
    create_table :tema_ayudas do |t|
      t.integer :orden
      t.string :tema_ayuda
      t.text :detalle

      t.timestamps
    end
    add_index :tema_ayudas, :orden
  end
end
