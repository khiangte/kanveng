class Member < ActiveRecord::Base
	scope :active, -> { where(active: true) }
	belongs_to :user

	has_many :posts

	# 		t.string			:full_name
 	#    	t.date 				:dob
	#     t.string			:epic_no
	#     t.string			:birth_place
	#     t.boolean 		:active, default: true
	#     t.string  		:sex, length: 15
	#     t.text				:photo_url
	#     t.text				:occupation
	#     t.text				:address
	#     t.boolean			:verified, default: false
	#     t.integer 		:user_id
end
