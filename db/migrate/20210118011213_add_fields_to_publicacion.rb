class AddFieldsToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :d_quote, :string
    add_column :publicaciones, :estado, :string
    add_index :publicaciones, :estado
    add_column :publicaciones, :academic_degree, :string
    add_column :publicaciones, :book, :string
    add_column :publicaciones, :editor, :string
    add_column :publicaciones, :ciudad_pais, :string
    add_column :publicaciones, :t_sha1, :string
    add_index :publicaciones, :t_sha1
    add_column :publicaciones, :unicidad, :string
    add_column :publicaciones, :journal, :string
    add_column :publicaciones, :doc_type, :string
    add_index :publicaciones, :doc_type
    add_column :publicaciones, :perfil_id, :integer
    add_index :publicaciones, :perfil_id

    remove_column :publicaciones, :investigador_id, :integer
  end
end
