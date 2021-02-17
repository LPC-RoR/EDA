class AddEmailToContacto < ActiveRecord::Migration[5.2]
  def change
    add_column :contactos, :email, :string
  end
end
