class CreateRepositorios < ActiveRecord::Migration[5.2]
  def change
    create_table :repositorios do |t|
      t.string :repositorio

      t.timestamps
    end
  end
end
