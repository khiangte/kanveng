class Group < ActiveRecord::Base
	enum group_type: [ :NGO, :Church, :Institution, :Government ]
	scope :active, -> { where(active: true) }
	has_many :users, :through => :member_groups
	has_many :member_groups
end
