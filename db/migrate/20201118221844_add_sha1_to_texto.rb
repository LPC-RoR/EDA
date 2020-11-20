class AddSha1ToTexto < ActiveRecord::Migration[5.2]
  def change
    add_column :textos, :sha1, :string, limit: 40
    add_index :textos, :sha1
  end
end
