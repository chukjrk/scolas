class AskBuyerToConfirmTransaction
  def self.call(transaction)
    account_sid = 'AC52f02b0b4b36028b00738d8f526ecca8' # TODO: Remove to env variable
    auth_token = 'ea9a17a04da093198710c20c9a34c545' # TODO: Remove to env variable
    twilio_phone_number = '+14156499179'

    client = Twilio::REST::Client.new account_sid, auth_token

    body = "You bought book with id = #{transaction.id}. Please confirm that you've recieved book by replying with: #{transaction.id} yes"
    client.api.account.messages.create(from: twilio_phone_number, to: '+1 515-612-2294', body: body)
  end
end