class AskBuyerToConfirmTransaction
  def self.call(transaction)
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])

    body = "You bought book with id = #{transaction.id}. Please confirm that you've recieved book by replying with: #{transaction.id} yes"
    client.api.account.messages.create(from: ENV['TWILIO_PHONE_NUMBER'], to: transaction.buyer.phone_number, body: body) 
  end
end