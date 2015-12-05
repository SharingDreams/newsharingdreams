class ArtistsController < ApplicationController

    before_action :can_change, only: [:edit, :update]

    before_action :require_authentication_artist, only: [:show]
    before_action :require_no_authentication_artist, only: [:new, :create]

    def new
        @artist = Artist.new
    end

    def create
        @artist = Artist.new(artist_params)

        if @artist.save
            redirect_to @artist, notice: "Artista cadastrado com sucesso!"
        else
            render action: :new
        end
    end

    def show
        @artist = Artist.friendly.find(params[:id])
    end

    def edit
        @artist = Artist.friendly.find(params[:id])
    end

    def update
        @artist = Artist.friendly.find(params[:id])

        if @artist.update(artist_params)
            redirect_to @artist, notice: "Artista editado com sucesso!"
        else
            render action: :edit
        end
    end

    private

    def artist_params
        params.require(:artist).permit(:username, :email, :country, :about, :birthday, :password, :password_confirmation)
    end

    def can_change
        unless artist_signed_in? && current_artist == artist
            redirect_to artist_path(params[:id])
        end
    end

    def artist
        @artist ||= Artist.friendlyfind(params[:id])
    end

end
