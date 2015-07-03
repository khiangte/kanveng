class AlertsController < ApplicationController
	before_action :authenticate_user!

	def create_alert
		msg = "Alert was not created!"
		if params[:user_id] && params[:message] && params[:group_id]
			group = Group.find_by_id(params[:group_id])
			if current_user.is_all_admin? || group && current_user.is_admin_of?(group)
				alert = Alert.create :user_id => params[:user_id], :message => params[:message], :group_id => params[:group_id]
				#alert.delay.send_sms
				msg = "Alert created!"
			end
		end
		alerts = Alert.where("group_id = ?", params[:group_id]).order('created_at desc').limit(10)
		render :json => {:message => view_context.alert_boxes(alerts), :msg => msg}
	end
end
