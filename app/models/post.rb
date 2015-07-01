class Post < ActiveRecord::Base
	enum post_type: [ :Announcement, :Suggestion, :Question, :Complaint ]
	scope :active, -> { where('expires_at > ?', Time.now) }
	scope :notactive, -> { where('expires_at < ?', Time.now) }
	scope :approved, -> {where.not(:approved_by => nil)}
	scope :unapproved, -> {where(:approved_by => nil)}
	scope :open,	-> {where(:public => true)}
	# 	    t.string		:title
	#     	t.text			:content
	#     	t.integer		:post_type
	#     	t.datetime	:expires_at
	#     	t.text			:attachment_url
	#     	t.integer		:group_id
	#     	t.integer		:member_id
	#     	t.boolean		:public
	#     	t.integer		:approved_by

	belongs_to :user
	belongs_to :group

	def approver
		User.find_by_id(approved_by)
	end

	def member
		user.member
	end

end
