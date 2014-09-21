module TwilioClient


  def twilio_client
    account_sid = 'AP61c343cb8a4779ec0782d76ecf061861'
    auth_token = '69186a7a72fa3dfc2343a7b8bc1f9ce3'
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

end