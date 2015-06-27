class BoardsController < ApplicationController
	# before_action :authenticate_user! {:except => 'index'}

	def index
		@public_posts = Post.active.approved.open
	end
end
