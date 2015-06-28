module PostsHelper
	def options_for_groups_select(user, selected = nil)
		groups = user.groups.collect{|g| [g.name, g.id]}
		groups.unshift(["None",0])
		options_for_select(groups,selected)
	end
end
