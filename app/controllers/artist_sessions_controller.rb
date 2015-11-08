class ArtistSessionsController < ApplicationController

    before_action :require_no_authentication_artist, only: [:new, :create]
    before_action :require_authentication_artist, only: [:destroy]

    def new
        @artist_session = ArtistSession.new(session)
    end

    def create
        @artist_session = ArtistSession.new(session, params[:artist_session])

        if @artist_session.authenticate!
            redirect_to root_path, notice: "Logado com sucesso!"
        else
            render :new
        end
    end

    def destroy
        artist_session.destroy
        redirect_to root_path, notice: "Logout realizado com sucesso!"
    end

end
