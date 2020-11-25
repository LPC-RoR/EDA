class AddDFieldsToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :d_journal, :string
    add_column :publicaciones, :d_author, :string
    add_column :publicaciones, :d_doi, :string
    add_column :publicaciones, :origen, :string
    add_column :publicaciones, :pages, :string
    add_column :publicaciones, :equipo_id, :integer
    add_column :publicaciones, :investigador_id, :integer
    add_index :publicaciones, :equipo_id
    add_index :publicaciones, :investigador_id

  end
end
