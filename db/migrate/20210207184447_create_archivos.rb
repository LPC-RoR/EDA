class CreateArchivos < ActiveRecord::Migration[5.2]
  def change
    create_table :archivos do |t|
      t.integer :orden
      t.string :archivo
      t.string :nota

      t.timestamps
    end
    add_index :archivos, :orden
  end
end
