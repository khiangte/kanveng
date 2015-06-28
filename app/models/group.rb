class Group < ActiveRecord::Base
	enum group_type: [ :NGO, :Church, :Institution, :Government ]
	scope :active, -> { where(active: true) }
	has_many :users, :through => :member_groups
	has_many :member_groups
	has_many :posts
	has_many :requests

	def admins
		member_groups.order(:updated_at).collect{|d| d.user if d.admin}
	end

	def members
		member_groups.collect{|d| d.user }
	end
end
