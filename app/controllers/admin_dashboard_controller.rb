class AdminDashboardController < ApplicationController
	def index
		@unapproved_posts = Post.active.unapproved
		@unverified_members = Member.active.unverified
	end
end
