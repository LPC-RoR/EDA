class CreateFormatoCargas < ActiveRecord::Migration[5.2]
  def change
    create_table :formato_cargas do |t|
      t.string :formato_carga

      t.timestamps
    end
  end
end
