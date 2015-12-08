class ConfirmationsController < ApplicationController
	def show
		artist = Artist.find_by(confirmation_token: params[:token])

		if artist.present?
			artist.confirm!

			redirect_to artist, notice: "Email confirmado! Bora mudar o mundo? ;)"
		else 
			redirect_to root_path
		end
	end
end