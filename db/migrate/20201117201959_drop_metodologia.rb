class DropMetodologia < ActiveRecord::Migration[5.2]
  def change
  	drop_table :metodologias
  end
end
