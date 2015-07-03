class Member < ActiveRecord::Base
	scope :active, -> { where(active: true) }
	scope :verified, -> {where(verified: true)}
	scope :unverified, -> {where(verified: false)}
	belongs_to :user
	
	validates_uniqueness_of :epic_no, :allow_nil => true, :allow_blank => true


	

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

	def is_verified?
		verified
	end
end
