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
			<td width="30%" class="text-right"> <span class="badge">' + member.epic_no.to_s + '</span></td>
		</tr>'
	end

	def member_form_search_row_html(member)
		'<tr>
			<td width="10%">' + profile_photo(member.photo_url,"30x30") + '</td>
			<td width="60%">' + link_to(member.full_name, "#", :name => member.full_name, :user_id => member.user_id, :class => "admin_name") + '</td>
			<td width="30%" class="text-right"> <span class="badge">' + member.epic_no + '</span></td>
		</tr>'
	end

	def member_request_row_html(member, request_id, msg)
		'<tr id = request_' + request_id.to_s + ' >
			<td width="10%">' + profile_photo(member.photo_url,"30x30") + '</td>
			<td width="70%">' + link_to(member.full_name, member_path(:id => member.id)) + ' &nbsp;&nbsp;&nbsp;' + msg + '</td>
			<td width="20%" id= td_' + request_id.to_s + '>' + link_to("Delete", "#", :request_id => request_id, :class => "delete_btn" ) + ' | ' + link_to(" Approve", "#", :request_id => request_id, :class => "approve_btn" ) + '</td>
		</tr>'
	end

	def contacts_view(user)
		symbols = {"Mobile" => "mobile", "Landline" => "phone", "Email" => "envelope-o", "Other" => "star"}
		op = ""
		if user_signed_in? && (current_user.is_all_admin? || current_user == user)
			user.contacts.each do |c|
				op += font_awesome(symbols[c.contact_type]) + ' ' + c.value + ' ' + (link_to font_awesome('pencil'), edit_contact_path(:id => c.id)) + " <br />".html_safe
			end
			op += link_to 'Add contact', new_contact_path(:user_id => user.id)
		else
			user.contacts.visible.each do |c|
				op += font_awesome(symbols[c.contact_type]) + ' ' + c.value + " <br />".html_safe
			end
		end
		op.html_safe
	end

end
