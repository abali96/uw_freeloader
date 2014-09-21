class Texter
  include TwilioClient

  def text
    account_sid = 'ACf21e0538bf4c18ee2a679080900b2065'
    auth_token = "69186a7a72fa3dfc2343a7b8bc1f9ce3"
    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.messages.create(
    :from => '+12898073438',
    :to => '+16478904632',
    :body => 'Hey there!'
  )
  end
end