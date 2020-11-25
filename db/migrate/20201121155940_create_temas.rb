class CreateTemas < ActiveRecord::Migration[5.2]
  def change
    create_table :temas do |t|
      t.string :tema
      t.integer :investigador_id

      t.timestamps
    end
    add_index :temas, :tema
    add_index :temas, :investigador_id
  end
end
