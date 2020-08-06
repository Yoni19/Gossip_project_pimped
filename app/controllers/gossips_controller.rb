class GossipsController < ApplicationController

  before_action :authenticate_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :currentuser_gossipauthor?, only: [:edit, :update, :destroy]

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(title:params[:title], content:params[:content], user_id:current_user.id) # avec xxx qui sont les données obtenues à partir du formulaire

    if @gossip.save # essaie de sauvegarder en base @gossip
      redirect_to '/'
      flash[:success] = "Potin créé ! Merci d'entretenir le commérage 👌"
      # si ça marche, il redirige vers la page d'index du site
    else
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      render 'new'
    end

  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])

    if @gossip.update(gossip_params)
      redirect_to @gossip
    else
      render :edit
    end

  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

  def currentuser_gossipauthor?
    unless current_user.id == Gossip.find(params[:id]).user.id
      redirect_to root_path
      flash[:danger] = "Non non non ;)"
    end
  end

end
