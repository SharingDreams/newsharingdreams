class Signup < ActionMailer::Base

	default from: 'nao-responda@sharingdreams.co'

	def confirm_email(artist)
		@artist = artist
		
		@confirmation_link = confirmation_url({
			token: @artist.confirmation_token
		})

		mail({
			to: artist.email,
			bcc: ['cadastro <cadastro@sharingdreams.co>'],
			subject: "Artista, bem vindo ao SharingDreams! :D"
		})
	end

end