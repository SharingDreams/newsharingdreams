class ArtistSession
    include ActiveModel::Model

    attr_accessor :email, :password

    validates_presence_of :email, :password

    def initialize(session, attributes={})
        @session = session
        @email = attributes[:email]
        @password = attributes[:password]
    end

    def authenticate!
        artist = Artist.authenticate(@email, @password)

        if artist.present?
            store(artist)
        else
            errors.add(:base, :invalid_login)
            false
        end
    end

    def store(artist)
        @session[:artist_id] = artist.id
    end

    def current_artist
        Artist.find(@session[:artist_id])
    end

    def artist_signed_in?
        @session[:artist_id].present?
    end

    def destroy
        @session[:artist_id] = nil
    end

end
