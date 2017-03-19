class MessagesController < ApplicationController
	before_action :authenticate_user!
	
	def create
		chat_room = Room.find(params[:room_id])
		if chat_room != nil && correct_user(chat_room)
			message = chat_room.messages.create(message: params[:message][:message], sender_name: current_user.name)
			if current_user.id == Room.find(params[:room_id]).seller_id
				Notification.create(recipient: chat_room.buyer, actor: current_user, action: "sent you a", notifiable: message)
			else
				Notification.create(recipient: chat_room.seller, actor: current_user, action: "sent you a", notifiable: message)
			end
			redirect_to room_url(chat_room)
		end
	end

	private

	  	def correct_user(room)
	  		if current_user.id == room.seller_id || current_user.id == room.buyer_id
	  			true
	  		else
	  			false
	  		end
	  	end
end