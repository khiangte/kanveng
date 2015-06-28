module GroupsHelper
	def group_icon(type_id = 'NGO')
		names = {'NGO' => 'flag-o', 'Church' => 'institution', 'Institution' => 'graduation-cap','Government' => 'building'}
		font_awesome(names[type_id])
	end
end
