require "colorize"

class AdminController < ApplicationController

	user = %w{LeoNava gu1vr Thor99 JoaoEscudero}
	pass = %w{LeCacv547?) 47xo2um2 loYxPhilipeto 47xo2um2}

	def new
		if verify_data(params[:username], params[:password])
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

	def accept_or_not
		if params[:accept] != nil
			params[:accept].each do |key, value|
				accept_art(key.to_i, value)
			end
		end

		redirect_to admin_index_path
	end

	private

	def accept_art(id, aceitar_ou_nao)
		if aceitar_ou_nao == "aceitar"
			art = Art.find(id)
			art.approved = 1
			art.save
		elsif aceitar_ou_nao == "nao_aceitar"
			Art.find(id).destroy
		end
	end

	def verify_data(username, password)
		if username == "LeoNava" && password = "LeCacv547?)"
			true
		elsif username == "gu1vr" && password = "47xo2um2"
			true
		elsif username == "Thor99" && password = "loYxPhilipeto"
			true
		elsif username == "JoaoEscudero" && password = "47xo2um2"
			true
		else
			false
		end		
	end
end