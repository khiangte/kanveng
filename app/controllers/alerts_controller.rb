class AlertsController < ApplicationController
	before_action :authenticate_user!

	def create_alert
		msg = "Alert was not created!"
		if params[:user_id] && params[:message] && params[:group_id]
			group = Group.find_by_id(params[:group_id])
			if current_user.is_all_admin? || current_user.is_admin_of?(group)
				alert = Alert.create :user_id => params[:user_id], :message => params[:message], :group_id => params[:group_id]
				send_alert_sms(alert)
				msg = "Alert created!"
			end
		end
		alerts = Alert.where("group_id = ?", params[:group_id]).order('created_at desc').limit(10)
		render :json => {:message => view_context.alert_boxes(alerts), :msg => msg}
	end

	private
	#should be handled in background as it may take time
	def send_alert_sms(alert)
		if(alert.group_id == 0)
			query = "select c.value from contacts c join users u on c.user_id = u.id where c.contact_type = 0 and u.deactivated = 0"
		else
			query = "select c.value from contacts c join users u on c.user_id = u.id join member_groups g on g.user_id = u.id where c.contact_type = 0 and u.deactivated = 0 and g.group_id = #{alert.group_id}"
		end
		recipients = ActiveRecord::Base.connection.execute(query).to_a.flatten
		#send_sms(recipients, alert.message)
	end
end
