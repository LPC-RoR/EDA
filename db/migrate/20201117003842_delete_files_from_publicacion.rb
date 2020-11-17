class DeleteFilesFromPublicacion < ActiveRecord::Migration[5.2]
  def change
  	remove_column :publicaciones, :language
  	remove_column :publicaciones, :journal
  end
end
