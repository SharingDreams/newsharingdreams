class PasswordResetMailer < ActionMailer::Base
	default from: 'nao-responda@sharingdreams.co'

	def password_reset(artist)
		@artist = artist
  		
  		mail({
			to: artist.email,
			bcc: ['nova senha <novasenha@sharingdreams.co>'],
			subject: "Artista, recupere sua senha :D"
		})
	end
end