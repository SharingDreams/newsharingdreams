class Artists::MyArtsController < ApplicationController
    def index
        if params[:q].blank?
            artist = Artist.friendly.find(params[:artist_id])
            @artist_arts = artist.arts.all.order("created_at DESC")
        else
            @search = params[:q]
            artist = Artist.friendly.find(params[:artist_id])
            arts_searched = artist.arts.search(@search)
            @artist_arts = arts_searched.all.order("created_at DESC").page(params[:page]).per(9)
        end

    end

    private

    def can_see_my_arts
        unless artist_signed_in? && current_artist == artist
            redirect_to root_path, alert: "Você não têm acesso!"
        end
    end

    def artist
        @artist ||= artist.friendly.find(params[:artist_id])
    end
end