class ArtistsController < ApplicationController

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
        @artist = Artist.find(params[:id])
    end

    def edit
        @artist = Artist.find(params[:id])
    end

    def update
        @artist = Artist.find(params[:id])

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

end
