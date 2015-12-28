class ArtsController < ApplicationController
    before_action :require_authentication_artist, only: [:new, :create, :edit, :update, :destroy]
    before_action :can_edit, only: [:edit, :update]

    def index
        if params[:q].blank?
            @arts = Art.all.order("created_at DESC").where(approved: 1).page(params[:page]).per(9)
        else
            @search = params[:q]
            arts_searched = Art.search(@search)
            @arts = arts_searched.order("created_at DESC").where(approved: 1).page(params[:page]).per(9)
        end
    end

    def new
        @art= current_artist.arts.build
    end

    def create
        @art = current_artist.arts.build(art_params)

        if @art.save
            redirect_to @art, notice: "Arte criada com sucesso!"
        else
            render action: :new
        end
    end

    def show
        @art = Art.friendly.find(params[:id])
        
        if @art.approved == 0
            redirect_to arts_path
        end

        @artist = Artist.friendly.find(@art.artist)
        @artist_arts = @artist.arts.limit(5).order("created_at DESC").where.not(id: @art.id).where(approved: 1)
    end

    def edit
        @art = current_citizen.arts.friendly.find(params[:id])
    end

    def update
        @art = current_citizen.arts.friendly.find(params[:id])

        if @art.update(art_params)
            redirect_to @art, notice: "Arte atualizada com sucesso!"
        else
            render action: :edit
        end
    end

    def destroy
        @art = Art.friendlyfind(params[:id])
        @art.destroy
        redirect_to root_path, notice: "Arte deletada com sucesso!"
    end

    private

    def art_params
        params.require(:art).permit(:title, :image)
    end

    def can_edit
        unless artist_signed_in? && art.artist == current_rtist
            redirect_to art_path(params[:id])
        end
    end

    def art
        @art ||= Art.friendly.find(params[:id])
    end
end