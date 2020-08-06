class CommentsController < ApplicationController

  def create
     @comment = Comment.new(content:params[:content], user_id:current_user.id, gossip_id:params[:id])
     if @comment.save
         redirect_to gossip_path(params[:id])
     else
         render "new"
     end
   end

end
