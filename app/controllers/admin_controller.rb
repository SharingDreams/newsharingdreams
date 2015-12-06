class AdminController < ApplicationController

	def new
		@username = params[:username]
		@pass = params[:pass]

		if @username == "leo" && @pass == "leo"
			redirect_to admins_path
		elsif 
			render action: :new, notice: "Errow!"
		end
	end

	def index
		@arts = Art.all.order("created_at DESC").where(approved: 0)
	end

end