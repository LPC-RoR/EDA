class CreateValores < ActiveRecord::Migration[5.2]
  def change
    create_table :valores do |t|
      t.string :tipo
      t.string :valor

      t.timestamps
    end
    add_index :valores, :tipo
  end
end
