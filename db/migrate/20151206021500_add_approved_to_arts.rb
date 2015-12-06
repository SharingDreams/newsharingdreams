class AddApprovedToArts < ActiveRecord::Migration
  def change
    add_column :arts, :approved, :integer
  end
end
