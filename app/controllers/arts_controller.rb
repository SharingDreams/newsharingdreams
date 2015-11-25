class ArtsController < ApplicationController
    def index
        @arts = Art.all.order("created_at DESC").page(params[:page]).per(1)
    end

    def new
        @art = Art.new
    end

    def create
        @art = Art.new(art_params)

        if @art.save
            redirect_to @art, notice: "Arte criada com sucesso!"
        else
            render action: :new
        end
    end

    def show
        @art = Art.friendly.find(params[:id])
    end

    def edit
        @art = Art.friendlyfind(params[:id])
    end

    def update
        @art = Art.friendlyfind(params[:id])

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
end