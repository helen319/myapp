class CommentsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
  	@post = Post.find(params[:post_id])
  	@comments = @post.comments
  end
  
  def new
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.build
  end
  
  def create
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.build(params[:comment])
  	@comment.user = current_user
  	if @comment.save
  		redirect_to :controller => 'users', :action => 'profile', :user_id => @post.user
  	else
  		redirect_to :controller => 'users', :action => 'profile', :user_id => @post.user
  	end
  end

  def delete
  	@post = Post.find(params[:post_id])
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  	
  	respond_to do |format|
	  format.html { redirect_to :back} 
	  format.xml { head :ok } 
	end
  end

end
