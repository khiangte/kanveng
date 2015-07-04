class PostsController < ApplicationController
	before_action :authenticate_user!

	def new_post
		if current_user.member.is_verified?
			@post = Post.new
			@post.group_id = params[:group_id] if current_user.groups.map(&:id).include?(params[:group_id].to_i)
		else
			@post = nil
		end
	end

	def create_post
		if current_user.member.is_verified?
			@post = Post.new(post_params)
			@post.user = current_user
			@post.approved_by = current_user.id if (current_user.is_all_admin? || current_user.is_admin_of?(@post.group))
			if @post.save
	  		redirect_to post_path(:id => @post.id)
	  	else
				flash[:notice] = "Post Not Created"
	  		render 'new_post'
	  	end
	  else
	  	flash[:notice] = "Not authorised!"
	  	redirect_to root_path
	  end
	end

	def posts
			@posts = Post.active.approved.open.limit(10).order('id desc')
	end

	def update_post
		@post = Post.active.find_by_id(post_params["id"])
		if current_user.member.is_verified? && (@post.member == current_user.member || current_user.is_admin_of?(@post.group)) || (current_user.role.is_all_admin? && @post.group.nil?)
			@post.update_attributes(post_params)
			@post.approved_by = nil if current_user.role.is_not_admin?
			if @post.save
				flash[:notice] = "Post Updated"
				redirect_to post_path(:id => @post.id)
			else
				redirect_to edit_post_path(:id => @post.id)
			end
		else
			flash[:notice] = "Not authorised!"
	  	redirect_to root_path
		end
	end

	def approve_post
		post = Post.find_by_id(params[:id])
		if post && post.group.nil? && current_user.is_all_admin? || post && current_user.is_admin_of?(post.group)
			post.approved_by = current_user.id
			if post.save
				render :json => {:success => true, :result => "Approved by #{current_user.member.full_name}"}
			end
		end
	end

	def edit_post
		@post = Post.active.find_by_id(params[:id])
		unless (current_user == @post.user || current_user.is_admin_of?(@post.group) || @post.group.nil? && @post.public && current_user.is_all_admin?)
			@post = nil
		end
	end

	def view_post
		@post = Post.active.find_by_id(params[:id])
		if @post && @post.approved_by.blank?
			if @post.group && (current_user != @post.user && !(current_user.is_admin_of?(@post.group)))
				@post = nil
			elsif current_user != @post.user && !current_user.is_all_admin?
				@post = nil
			end
		end
	end

	private
  def post_params
  	params.require(:post).permit!
  end
end
