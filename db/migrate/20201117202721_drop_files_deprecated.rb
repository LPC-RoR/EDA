class DropFilesDeprecated < ActiveRecord::Migration[5.2]
  def change
  	drop_table :referencias
  	drop_table :conceptos
  	drop_table :agregaciones
  	drop_table :origenes
  	drop_table :repositorios
  end
end
