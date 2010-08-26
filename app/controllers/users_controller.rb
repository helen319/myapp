class UsersController < ApplicationController

  before_filter :authenticate_user!

  def show
  	@users = User.all(:order => "created_at DESC")
  		respond_to do |format|
			format.html
			format.xml { render:xml => @users}
		end
  end  
  	

  def profile
    @user = User.find(params[:user_id])
    @posts = @user.posts.all(:order => "created_at DESC")  
    respond_to do |format|
		format.html
		format.xml { render:xml => @user}
	
	end  
  end

 
end 



