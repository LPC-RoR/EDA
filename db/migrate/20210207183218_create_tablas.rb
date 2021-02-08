class CreateTablas < ActiveRecord::Migration[5.2]
  def change
    create_table :tablas do |t|
      t.integer :orden
      t.string :tabla
      t.integer :padre_id

      t.timestamps
    end
    add_index :tablas, :orden
    add_index :tablas, :padre_id
  end
end
