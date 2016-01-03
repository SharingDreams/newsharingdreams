class PasswordResetsController < ApplicationController

	def create
		artist = Artist.find_by(email: params[:username_or_email]) || Artist.find_by(username: params[:username_or_email])
		artist.send_password_reset if artist

		redirect_to root_url, :notice => "Email enviado para você!"
	end

	def edit
		@artist = Artist.find_by(password_reset_token: params[:id])

		unless @artist
			redirect_to root_url
		end
	end

	def update
		@artist = Artist.find_by(password_reset_token: params[:id])

  		if @artist.password_reset_sent_at < 24.hours.ago
    		redirect_to new_password_reset_path, :alert => "Password reset has expired."
  		elsif @artist.update_attributes(artist_params)
    		redirect_to root_url, :notice => "Password has been reset!"
  		else
    		render :edit
  		end
	end

	private

    def artist_params
        params.require(:artist).permit(:username, :full_name, :email, :country, :about, :birthday, :password, :password_confirmation, :photo)
    end
end
