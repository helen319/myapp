class PostsController < ApplicationController  

	before_filter :authenticate_user!
	
	#home page which shows all posts
	def index  
		@posts = current_user.posts.all(:order => "created_at DESC")  
		
		respond_to do |format|
			format.html
			format.xml { render:xml => @posts}
		end
	end  

	#show only one post
	def show
		@post = Post.find(params[:id])
		
		respond_to do |format|
			format.html
			format.xml { render:xml => @post}
		end
	end
		
		
	#create a new post
	def create  
		if params[:message] != ''
			@post = Post.create(:message => params[:message])  
			@post.user = current_user
			respond_to do |format|  
				if @post.save  
					flash[:notice] = 'Post was successfully created.'
					format.html { redirect_to posts_path }  
					format.xml { render:xml => @post}
				else  
					flash[:notice] = "Message failed to save."  
					format.html { redirect_to posts_path }
					format.xml { render :xml => @post.errors,  
									:status => :unprocessable_entity } 
				end  
			end
		else
			redirect_to(posts_url)
		end
  	end  
  	
  	#delete a post
  	def delete
  		@post = Post.find(params[:id])  
  		@post.destroy 
  		
  		respond_to do |format| 
  			format.html { redirect_to(posts_url) } 
  			format.xml { head :ok }
  		end 
  	end 
  	
  	private 
  		def find_post 
  			@post = Post.find(params[:id])  
  			
  		end 
end  
