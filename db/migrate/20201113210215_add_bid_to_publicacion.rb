class AddBidToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicaciones, :ingreso, :string
    add_column :publicaciones, :author, :string
    add_column :publicaciones, :title, :string
    add_index :publicaciones, :title
    add_column :publicaciones, :journal, :string
    add_column :publicaciones, :year, :string
    add_column :publicaciones, :volume, :string
    add_column :publicaciones, :month, :string
#    add_column :publicaciones, :abstract, :text
    add_column :publicaciones, :publisher, :string
    add_column :publicaciones, :address, :string
    add_column :publicaciones, :type, :string
    add_column :publicaciones, :language, :string
    add_column :publicaciones, :affiliation, :string
    add_column :publicaciones, :carga_id, :integer
    add_index :publicaciones, :carga_id
    add_column :publicaciones, :article_number, :string
    add_column :publicaciones, :issn, :string
    add_column :publicaciones, :eissn, :string
#    add_column :publicaciones, :keywords, :string
    add_column :publicaciones, :keywords_plus, :string
    add_column :publicaciones, :research_areas, :string
    add_column :publicaciones, :web_of_science_categories, :string
    add_column :publicaciones, :author_email, :string
    add_column :publicaciones, :unique_id, :string
    add_index :publicaciones, :unique_id
    add_column :publicaciones, :da, :string
  end
end
