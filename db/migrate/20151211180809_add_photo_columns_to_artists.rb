class AddPhotoColumnsToArtists < ActiveRecord::Migration
  def up
    add_attachment :artists, :photo
  end

  def down
    remove_attachment :artists, :photo
  end
end
