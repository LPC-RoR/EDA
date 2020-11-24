class AddSha1ToEquipo < ActiveRecord::Migration[5.2]
  def change
    add_column :equipos, :sha1, :string, limit: 40
    add_index :equipos, :sha1
  end
end
