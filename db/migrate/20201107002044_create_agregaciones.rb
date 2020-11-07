class CreateAgregaciones < ActiveRecord::Migration[5.2]
  def change
    create_table :agregaciones do |t|
      t.integer :categoria_id
      t.integer :concepto_id

      t.timestamps
    end
    add_index :agregaciones, :categoria_id
    add_index :agregaciones, :concepto_id
  end
end
