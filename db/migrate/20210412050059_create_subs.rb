class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    add_index :subs, :parent_id
    add_index :subs, :child_id
  end
end
