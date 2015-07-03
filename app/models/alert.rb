class Alert < ActiveRecord::Base
	belongs_to :user

	def send_sms
		if(group_id == 0)
			query = "select c.value from contacts c join users u on c.user_id = u.id where c.contact_type = 0 and u.deactivated = false"
		else
			query = "select c.value from contacts c join users u on c.user_id = u.id join member_groups g on g.user_id = u.id where c.contact_type = 0 and u.deactivated = false and g.group_id = #{alert.group_id}"
		end
		recipients = ActiveRecord::Base.connection.execute(query).to_a.flatten
		Delayed::Worker.logger.debug("sending msg to #{recipients.size} numbers")
		#Send code here
		Delayed::Worker.logger.debug("sent msg to #{recipients.size} numbers")
	end
end