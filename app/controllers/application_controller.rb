class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    delegate :current_artist, :artist_signed_in?, to: :artist_session

    helper_method :current_artist, :artist_signed_in?

    def require_authentication_artist
        unless artist_signed_in?
            redirect_to new_artist_sessions_path, alert: "Deve estar logado!"
        end
    end

    def require_no_authentication_artist
        if artist_signed_in?
            redirect_to root_path, alert: "Usuário já se encontra logado!"
        end
    end

    def artist_session
        ArtistSession.new(session)
    end

end
