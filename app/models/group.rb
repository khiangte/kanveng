class Group < ActiveRecord::Base
	enum group_type: [ :NGO, :Church, :Institution, :Government ]
	scope :active, -> { where(active: true) }
	has_many :users, :through => :member_groups
	has_many :member_groups
	has_many :posts
	has_many :requests

	def admin_members
		member_groups.where("admin = ?", true).order('updated_at desc').collect{|d| d.user.member}
	end

	def admins
		member_groups.where("admin = ?", true).order('updated_at desc').collect{|d| d.user}
	end

	def members
		member_groups.collect{|d| d.user unless d.user.deactivated }
	end
end
