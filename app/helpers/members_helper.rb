module MembersHelper
	def font_awesome(icon="skyatlas")
		('<i class="fa fa-' + icon + '"></i>').html_safe
	end

	def profile_photo(photo_url = "him.png", size="100x100", alt = "Member", class_name = 'img-circle')
		photo_url = "him.png" if photo_url.blank?
		image_tag(photo_url, size: size, alt: alt, :class => class_name)
	end

	def age(dob)
	  now = Time.now.utc.to_date
	  now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end

	def member_search_row_html(member)
		'<tr>
			<td width="10%">' + profile_photo(member.photo_url,"30x30") + '</td>
			<td width="60%">' + link_to(member.full_name, member_path(:id => member.id)) + '</td>
			<td width="30%" class="text-right"> <span class="badge">' + member.epic_no + '</span></td>
		</tr>'
	end

	def member_form_search_row_html(member)
		'<tr>
			<td width="10%">' + profile_photo(member.photo_url,"30x30") + '</td>
			<td width="60%">' + link_to(member.full_name, "#", :name => member.full_name, :user_id => member.user_id, :class => "admin_name") + '</td>
			<td width="30%" class="text-right"> <span class="badge">' + member.epic_no + '</span></td>
		</tr>'
	end

	def member_request_row_html(member, request_id)
		'<tr id = request_' + request_id.to_s + ' >
			<td width="10%">' + profile_photo(member.photo_url,"30x30") + '</td>
			<td width="40%">' + link_to(member.full_name, member_path(:id => member.id)) + '</td>
			<td width="30%" class="text-right"> <span class="badge">' + member.epic_no + '</span></td>
			<td width="20%">' + link_to(font_awesome('check') + " Approve", "#", :request_id => request_id, :class => "approve_btn" ) + '</td>
		</tr>'
	end
end
