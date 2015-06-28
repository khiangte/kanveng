module GroupsHelper
	def group_icon(type_id = 'NGO')
		names = {'NGO' => 'flag-o', 'Church' => 'institution', 'Institution' => 'graduation-cap','Government' => 'building'}
		font_awesome(names[type_id])
	end

	def group_logo(photo_url = "logo.png", size="150x150", alt ="Group LOGO", class_name = 'img-circle')
		photo_url = "logo.png" if photo_url.blank?
		image_tag(photo_url, size: size, alt: alt, :class => class_name)
	end
end
