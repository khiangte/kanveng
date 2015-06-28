class MembersController < ApplicationController
	before_action :authenticate_user!

	def new_member
		@member = Member.new
	end

	def create_member
		@member = Member.new(member_params)
		if @member.save
  			redirect_to member_path(:id => @member.id)
  		else
			flash[:notice] = "Member Profile Not Created"
  			render 'new_member'
  		end
	end

	def members
			@members = Member.active.limit(10).order('id desc')
	end

	def search_members
		#improve this search... why am i limitting the attributes
		result = "No Results!"
		unless params[:search_param].blank?
			@members = Member.active.select(:id, :firstname, :lastname, :photo_url, :membership_no, :membership_type)
			.where("full_name like ? or epic_no = ?", "%#{params[:search_param]}%", params[:search_param],)
			.order(:full_name)
			unless @members.blank?
				result = ""
				@members.each do |member| #view_context here to call helper method from controller
					result += view_context.member_search_row_html(member)
				end
			end
		end
		render :json => {:success => true, :message => result }
	end

	def update_member
		@member = Member.active.find_by_id(member_params["id"])
		@member.update_attributes(member_params)
		if @member.save
			flash[:notice] = "Member Profile Updated"
			redirect_to member_path(:id => @member.id)
		else
			redirect_to edit_member_path(:id => @member.id)
		end
	end

	# def autosuggest_member
 #  	@suggest = Member.select("id, firstname, lastname, photo_url, membership_no").where("firstname LIKE ? or lastname LIKE ?", "%#{params[:member_name]}%","%#{params[:member_name]}%").limit(15) || []
 #  	result=[]
 #  	@suggest.each { |f| result << f.firstname }
 #  	render :json => {:sugg => result}
 #  end

	def edit_member
		if current_user.is_all_admin? || current_user.member.id == params[:id]
			@member = Member.active.find_by_id(params[:id])
		else
			@member = nil
		end
	end

	def view_member
		@member = Member.active.find_by_id(params[:id])
	end

	# def deactivate_member
	# 	@member = Member.find_by_id(params[:id])
	# 	@member.active = false
	# 	flash[:notice] = "Member profile " + @member.fullname + " deactivated"
	# 	redirect_to root_path
	# end
	def approve_member
		post = Post.find_by_id(params[:id])
		post.approved_by = current_user.id
		if post.save
			render :json => {:success => true, :result => "Approved by #{current_user.member.full_name}"}
		end
	end

	private
  def member_params
  	params.require(:member).permit!
  end
end
