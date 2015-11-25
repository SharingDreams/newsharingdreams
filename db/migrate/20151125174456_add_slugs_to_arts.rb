class AddSlugsToArts < ActiveRecord::Migration
  def change
    add_column :arts, :slug, :string
    add_index :arts, :slug, unique: true
  end
end
