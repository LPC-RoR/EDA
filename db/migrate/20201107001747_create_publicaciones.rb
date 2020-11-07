class CreatePublicaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :publicaciones do |t|
      t.string :titulo
      t.integer :annio
      t.string :paginas
      t.string :link
      t.string :abstract
      t.integer :registro_id
      t.integer :revista_id

      t.timestamps
    end
    add_index :publicaciones, :registro_id
    add_index :publicaciones, :revista_id
  end
end
