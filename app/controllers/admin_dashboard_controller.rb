class AdminDashboardController < ApplicationController
	before_action :authenticate_user!
	before_action :verify_admin
	def index
		@unapproved_posts = Post.active.unapproved.open
		@unverified_members = Member.active.unverified
	end

	def manage_groups
		@groups = Group.active
	end

	def alerts
		@alerts = Alert.where("group_id = ?", 0).order('created_at desc').limit(10)
	end

	def system_data
		@about_data = SystemDatum.where("system_data_type = ?", '1')
		@contact_data = SystemDatum.where("system_data_type = ?", '0')
	end

	private
	def verify_admin
		redirect_to root_path unless current_user.is_all_admin?
	end
end
