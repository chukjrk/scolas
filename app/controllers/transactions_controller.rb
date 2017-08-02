require 'securerandom'
class TransactionsController < ApplicationController
	before_action :authenticate_user!, except: :confirm
	skip_before_action :verify_authenticity_token, only: :confirm

	def create
		listing = Listing.find(params[:listing_id])
		check = false
		error_message = "Unable to purchase product"
		if listing != nil
			
			current_user.with_lock do
				if current_user.can_buy?(listing.price)

					chat_room = Room.new(seller_id: listing.user.id, buyer_id: current_user.id, listing_id: listing.id)
					chat_room.save

					chat_room.messages.create(message: params[:message], sender_name: current_user.email)
					
					transaction = Transaction.new(seller_id: listing.user.id,
												  buyer_id: current_user.id,
												  listing_id: listing.id,
												  points: listing.price,
												  serial_number: genereate_serial,
												  room_id: chat_room.id)

					current_user.withdraw(listing.price)
					listing.displayable = false

					check = listing.save
					check = current_user.save && check
					check = transaction.save && check

					# TODO: Should it be removed? Ask Jr Kem
					Notification.create(recipient: listing.user, actor: current_user, action: "posted", notifiable: transaction)
					NotifySellerBookBought.call(ENV['MY_PHONE_NUMER']) # TODO: Use seller numer after merging changes from master branch
					AskBuyerToConfirmTransaction.delay(run_at: 5.minute.from_now, queue: 'sms').call(transaction)
				else
					error_message = "You do not have enough points"
				end
			end
		end
		
		if check
			flash[:success] = "Successfully purchased product"
			redirect_to listings_url
		else
			flash[:danger] = error_message
			redirect_to listings_url(listing)
		end
	end

	def confirm
		body_params = params['Body'].split(' ')
		transaction_id = body_params[0].try(:strip)
		answer = body_params[1].try(:strip)

		if AnsweredWithYes.call(answer)
			if transaction = Transaction.find_by(id: transaction_id)
				AddPointsToSeller.call(transaction)
			else
				ConfirmationFailed.call("Transaction with id = #{transaction_id} doesn't exists")
			end
		else
			ConfirmationFailed.call("You didn't answer with yes")
		end

		head :ok
	end


	def purchasing
	   @purchasing = current_user.purchasing_list
	end

	def sell
	   @sell = current_user.sell_list
	   @archive = Archive.new
	end

	def genereate_serial
		o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
		string = (0...6).map { o[rand(o.length)] }.join
	end
end