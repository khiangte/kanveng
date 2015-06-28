class PostsController < ApplicationController
	before_action :authenticate_user!

	def new_post
		if current_user.member.is_verified?
			@post = Post.new
		else
			@post = nil
		end
	end

	def create_post
		@post = Post.new(post_params)
		@post.user = current_user
		if @post.save
  			redirect_to post_path(:id => @post.id)
  		else
			flash[:notice] = "Post Profile Not Created"
  			render 'new_post'
  		end
	end

	def posts
			@posts = Post.active.approved.open.limit(10).order('id desc')
	end

	def update_post
		@post = Post.active.find_by_id(post_params["id"])
		@post.update_attributes(post_params)
		if @post.save
			flash[:notice] = "Post Profile Updated"
			redirect_to post_path(:id => @post.id)
		else
			redirect_to edit_post_path(:id => @post.id)
		end
	end

	def approve_post
		post = Post.find_by_id(params[:id])
		post.approved_by = current_user.id
		if post.save
			render :json => {:success => true, :result => "Approved by #{current_user.member.full_name}"}
		end
	end

	def edit_post
		@post = Post.active.find_by_id(params[:id])
	end

	def view_post
		@post = Post.active.find_by_id(params[:id])
	end

	private
  def post_params
  	params.require(:post).permit!
  end
end
