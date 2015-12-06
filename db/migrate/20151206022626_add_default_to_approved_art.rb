class AddDefaultToApprovedArt < ActiveRecord::Migration
  	def up
  		change_column :arts, :approved, :integer, default: 0
	end

	def down
  		change_column :arts, :approved, :integer
	end
end
