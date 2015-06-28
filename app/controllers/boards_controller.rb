class BoardsController < ApplicationController
	# before_action :authenticate_user! {:except => 'index'}

	def index
		@public_posts = []
		@private_posts = []
		if user_signed_in?
			posts = current_user.visible_posts.order("created_at desc")
			posts.each do |post|
				if post.public
					@public_posts << post 
				else
					@private_posts << post
				end
			end
		else
			@public_posts = Post.active.approved.open.order("created_at desc")
		end
	end

	def admins
		@admins = User.admins
	end
end
