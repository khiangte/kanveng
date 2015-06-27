class Group < ActiveRecord::Base
	enum group_type: [ :NGO, :Church, :Institution, :Government ]
end
