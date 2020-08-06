class UsersController < ApplicationController

  def show
    @author = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(first_name:params[:first_name], last_name:params[:last_name], email:params[:email], password:params[:password], city_id:City.last.id) # avec xxx qui sont les données obtenues à partir du formulaire

    if @user.save # essaie de sauvegarder en base @gossip
      session[:user_id] = @user.id
      redirect_to root_path
      # si ça marche, il redirige vers la page d'index du site
    else
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      render 'new'
    end
  end

end
