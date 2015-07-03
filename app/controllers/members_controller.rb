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
			@members = Member.active.verified.limit(10).order('id desc')
	end

	def search_members
		#improve this search... why am i limitting the attributes
		result = "No Results!"
		unless params[:search_param].blank?
			members = Member.active.verified.select(:id, :full_name, :photo_url, :epic_no)
			.where("full_name like ? or epic_no = ?", "%#{params[:search_param]}%", params[:search_param])
			.order(:full_name)
			unless members.blank?
				result = ""
				members.each do |member| #view_context here to call helper method from controller
					result += view_context.member_search_row_html(member)
				end
			end
		end
		render :json => {:success => true, :message => result }
	end

	def search_group_members
		result = "No Results!"
		unless (params[:search_param].blank? || params[:group_id].blank?)
				members = Member.find_by_sql("select m.* from members m join users on m.user_id = users.id join member_groups mg on users.id = mg.user_id 
					and mg.group_id= #{params[:group_id]} and full_name like '%#{params[:search_param]}%' order by full_name")
			unless members.blank?
				result = ""
				members.each do |member| #view_context here to call helper method from controller
					result += view_context.member_search_row_html(member)
				end
			end
		end
		render :json => {:success => true, :message => result }
	end

	def search_members_for_form
		#improve this search... why am i limitting the attributes
		result = "No Results!"
		unless params[:search_param].blank?
			@members = Member.active.verified.select(:id, :full_name, :photo_url, :epic_no, :user_id)
			.where("full_name like ? or epic_no = ?", "%#{params[:search_param]}%", params[:search_param])
			.order(:full_name)
			unless @members.blank?
				result = ""
				@members.each do |member| #view_context here to call helper method from controller
					result += view_context.member_form_search_row_html(member)
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

	def edit_member
		if current_user.is_all_admin? || current_user.member.id.to_s == params[:id]
			@member = Member.active.find_by_id(params[:id])
		else
			@member = nil
		end
	end

	def view_member
		if user_signed_in? && current_user.is_all_admin?
			@member = Member.find_by_id(params[:id])
		else
			@member = Member.active.find_by_id(params[:id])
		end
	end

	def deactivate_member
		if current_user.is_all_admin?
			user = User.find_by_id(params[:user_id])
			member = user.member
			member.active = false
			member.save
			user.contacts.destroy_all
			user.deactivated = true
			user.save
			Deactivation.create :user_id => user.id, :effective_date => params[:effective_date].to_date, :reason => params[:reason]
			render :json => {:message => "Deactivated"}
		else
			render :json => {:message => "Error"}
		end
	end

	def reactivate_member
		if current_user.is_all_admin?
			user = User.find_by_id(params[:user_id])
			member = user.member
			member.active = true
			member.save
			user.deactivated = false
			user.save
			x = Deactivation.find_by user_id: user.id
			x.delete
			flash[:notice] = "Reactivated member"
			redirect_to member_path(:id => member.id)
		else
			flash[:notice] = "Not Authorised"
			redirect_to root_path
		end
	end

	def verify_member
		if current_user.is_all_admin?
			member = Member.find_by_id(params[:id])
			member.verified = true
			if member.save
				render :json => {:success => true, :result => ("Verified " + view_context.font_awesome('check-circle-o')).html_safe}
			else
			render :json => {:message => "Error"}
			end
		else
			render :json => {:message => "Error"}
		end
	end

	private
  def member_params
  	params.require(:member).permit!
  end
end
