class CreateCarpetas < ActiveRecord::Migration[5.2]
  def change
    create_table :carpetas do |t|
      t.string :carpeta

      t.timestamps
    end
  end
end
