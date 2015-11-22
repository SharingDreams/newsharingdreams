class ArtistSession
    include ActiveModel::Model

    attr_accessor :username, :password

    validates_presence_of :username, :password

    def initialize(session, attributes={})
        @session = session
        @username = attributes[:username]
        @password = attributes[:password]
    end

    def authenticate!
        artist = Artist.authenticate(@username, @password)

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
