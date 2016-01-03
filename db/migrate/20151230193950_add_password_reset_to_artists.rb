class AddPasswordResetToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :password_reset_token, :string
    add_column :artists, :password_reset_sent_at, :datetime
  end
end
