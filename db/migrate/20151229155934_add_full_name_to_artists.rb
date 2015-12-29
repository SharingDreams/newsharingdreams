class AddFullNameToArtists < ActiveRecord::Migration
  def change
  	add_column :artists, :full_name, :string
  end
end
