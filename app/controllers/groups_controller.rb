class GroupsController < ApplicationController
	before_action :authenticate_user!, :except => [:view_group, :groups] 

	def new_group
		if current_user.is_all_admin?
			@group = Group.new
		else
			@group = nil
		end
	end

	def create_group
		if current_user.is_all_admin?
			group = Group.new(group_params)
			admin_user = User.find_by_id(params[:admin_id]) unless params[:admin_id].blank?
			if group.save
				group.reload
				if admin_user
						membership = MemberGroup.where("user_id = ? and group_id = ?", admin_user.id, group.id).first_or_create
						membership.user_id = admin_user.id
						membership.group_id = group.id
						membership.admin = true	
						membership.save
						admin_user.role_id = 3 if admin_user.role_id == 4 #upgrade to group admin
				end
	  		redirect_to group_path(:id => group.id)
	  	else
				flash[:notice] = "Group Profile Not Created"
	  			render 'new_group'
	  	end
	  else
	  	flash[:notice] = "Group Profile Not Created"
	  	redirect_to root_path
	  end
	end

	def pending_group_posts
		@group = Group.active.find_by_id(params["id"])
		if current_user.is_admin_of? @group	
			@posts = @group.posts.unapproved
		else
			flash[:notice] = "Only group admin can approve posts"
			redirect_to group_path(:id => params[:id])
		end
	end

	def approve_join_request
		request = Request.find_by_id(params[:request_id])
		if request && current_user.is_admin_of?(request.group)
			MemberGroup.create :user_id => request.user_id, :group_id => request.group_id
			request.delete
			render :json =>{:success => true}
		else
			render :json =>{:error => "error", :message => request ? "Permisson denied" : "Request not found"}
		end
		
	end

	def join_requests
		@group = Group.active.find_by_id(params["id"])
		if current_user.is_admin_of? @group	
			@requests = @group.requests
		else
			flash[:notice] = "Only group admin can approve join requests"
			redirect_to group_path(:id => params[:id])
		end
	end

	def request_join_group
		Request.create :user_id => params[:user_id], :group_id => params[:group_id], :message => params[:message]
		render :json => {:success => true}
	end

	def groups
		@groups = Group.active.order('name')
		@mygroups = []
		if user_signed_in?
			@mygroups = current_user.groups.active
			@groups = @groups - @mygroups
		end
	end

	def group_members
		@group = Group.active.find_by_id(params[:id])
		if current_user.is_member_of?(@group)
			@members = @group.member_groups.limit(3).order("created_at desc").collect{|q| q.user.member}
			@admins = @group.admins
		else
			redirect_to group_path(:id => @group)
		end
	end

	def update_group
		@group = Group.active.find_by_id(group_params["id"])
		if current_user.is_all_admin? || current_user.is_admin_of?(@group)
			@group.update_attributes(group_params)
			admin_user = User.find_by_id(params[:admin_id]) unless params[:admin_id].blank?
			if admin_user
					membership = MemberGroup.where("user_id = ? and group_id = ?", admin_user.id, @group.id).first_or_create
					membership.user_id = admin_user.id
					membership.group_id = @group.id
					membership.admin = true	
					membership.save
					admin_user.role_id = 3 if admin_user.role_id == 4 #upgrade to group admin
			end
			if @group.save
				flash[:notice] = "Group Profile Updated"
				redirect_to group_path(:id => @group.id)
			else
				redirect_to edit_group_path(:id => @group.id)
			end
		else
	  	flash[:notice] = "Group Profile Not Updated"
	  	redirect_to root_path
	  end
	end

	def edit_group
		@group = Group.active.find_by_id(params[:id])
		unless @group && (current_user.is_all_admin? || current_user.is_admin_of?(@group))
			@group = nil
		end
	end

	def view_group
		@group = Group.active.find_by_id(params[:id])
		if @group && user_signed_in? && current_user.is_member_of?(@group)
			@posts = @group.posts.active.approved
		elsif @group
			@posts = @group.posts.active.approved.open
		end
	end

	private
  def group_params
  	params.require(:group).permit!
  end
end
