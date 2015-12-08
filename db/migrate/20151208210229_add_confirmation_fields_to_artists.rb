class AddConfirmationFieldsToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :confirmed_at, :datetime
    add_column :artists, :confirmation_token, :string
  end
end
