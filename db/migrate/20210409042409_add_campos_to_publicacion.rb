class AddCamposToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :booktitle, :string
    add_column :publicaciones, :series, :string
    add_column :publicaciones, :number, :string
    add_column :publicaciones, :note, :string
    add_column :publicaciones, :meeting, :string
  end
end
