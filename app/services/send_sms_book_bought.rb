class SendSMSBookBought
  def call()
    account_sid = 'AC82355794d7fdc60672804ccdd6ae6ca3' # TODO: Remove to env variable
    auth_token = 'bb170d3fd1fbd9d82d039a8170de220b' # TODO: Remove to env variable
    twilio_phone_number = '+14156499179'

    client = Twilio::REST::Client.new account_sid, auth_token
    client.api.account.messages.create(from: twilio_phone_number, to: '+1 515-612-2294', body: 'You have a Buyer')
  end
end