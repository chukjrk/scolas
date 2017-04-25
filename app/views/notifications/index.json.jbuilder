json.array! @notifications do |notification|
	json.recipient notification.recipient
	json.actor notification.actor.name
	json.action notification.action
	json.notifiable do #notification.notifiable
		json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}" + "<br />"
	end

	if notification.notifiable_type == "Message"
		json.url room_path(item.room_id)
	end

	if notification.notifiable_type == "Transaction"
		json.url sell_path
	end

end