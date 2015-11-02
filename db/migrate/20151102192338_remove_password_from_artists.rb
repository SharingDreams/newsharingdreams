class RemovePasswordFromArtists < ActiveRecord::Migration
  def change
    remove_column :artists, :password, :string
  end
end
