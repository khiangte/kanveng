module AlertsHelper
	def alert_boxes(alerts)
		result = ''
		alerts.each do |alert| 
			result += '<div class="col-xs-12 col-md-4">
							<b>Message:</b> ' + alert.message + ' <br /> 
							<b>Sent by:</b> ' + alert.user.full_name + ' <br />
							<b>Time:</b> ' + local_time(alert.created_at) + ' <br />
							<b>Status: </b> ' + (alert.sent ? 'Sent' : 'Queued/Not Yet Sent') + '<br /><br/></div>'
		end
		result.html_safe
	end
end
