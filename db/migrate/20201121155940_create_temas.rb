class CreateTemas < ActiveRecord::Migration[5.2]
  def change
    create_table :temas do |t|
      t.string :tema

      t.timestamps
    end
    add_index :temas, :tema
  end
end
