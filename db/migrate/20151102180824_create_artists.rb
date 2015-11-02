class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|

        t.string :username
        t.string :email
        t.string :password
        t.string :country
        t.string :birthday
        t.text :about

        t.timestamps
    end
  end
end
