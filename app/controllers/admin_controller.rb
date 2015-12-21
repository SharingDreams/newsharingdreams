class AdminController < ApplicationController
	def new
		@username = params[:username]
		@pass = params[:password]

		if @username == "leo" and @pass == "leo"
			cookies[:admin] = { 
				:value => "adminlollolololol", 
				:expires => 1.hour.from_now 
			}

			redirect_to admin_index_path
		elsif 
			render action: :new, notice: "Errow!"
		end
	end

	def index
		if cookies[:admin].blank?
			redirect_to root_path
		end

		@arts = Art.all.order("created_at DESC").where(approved: 0)
	end
end