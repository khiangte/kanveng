class GroupsController < ApplicationController
	before_action :authenticate_user!

	def new_group
		if current_user.is_all_admin?
			@group = Group.new
		else
			@group = nil
		end
	end

	def create_group
		if current_user.is_all_admin?
			@group = Group.new(group_params)
			if @group.save
	  			redirect_to group_path(:id => @group.id)
	  	else
				flash[:notice] = "Group Profile Not Created"
	  			render 'new_group'
	  	end
	  else
	  	flash[:notice] = "Group Profile Not Created"
	  	redirect_to root_path
	  end

	end

	def groups
			@groups = Group.active.order('name')
	end

	def update_group
		if current_user.is_all_admin?
			@group = Group.active.find_by_id(group_params["id"])
			@group.update_attributes(group_params)
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
		if current_user.is_all_admin? || current_user.is_group_admin?
			@group = Group.active.find_by_id(params[:id])
		else
			@group = nil
		end
	end

	def view_group
		@group = Group.active.find_by_id(params[:id])
	end

	private
  def group_params
  	params.require(:group).permit!
  end
end
