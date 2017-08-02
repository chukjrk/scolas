class NotifySellerBookBought
  def self.call(to)
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    client.api.account.messages.create(from: ENV['TWILIO_PHONE_NUMBER'], to: to, body: 'You have a Buyer')
  end
end