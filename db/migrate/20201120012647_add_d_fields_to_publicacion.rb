class AddDFieldsToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :d_journal, :string
    add_column :publicaciones, :d_author, :string
    add_column :publicaciones, :d_doi, :string
    add_column :publicaciones, :origen, :string
    add_column :publicaciones, :pages, :string
  end
end
