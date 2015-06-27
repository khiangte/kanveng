class Role < ActiveRecord::Base
	has_many :users
		# name         level 
		# Master           1 
		# All Admin        2 
		# Group Admin      3 
		# User             4 
	def can_approve_member?
		[1,2].include? level
	end

	def can_create_member?
		[1,2].include? level
	end

	def can_approve_public_post?
		[1,2].include? level
	end

	def can_approve_group_post?
		level == 3
	end

end
