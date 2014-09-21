class Texter
  include TwilioClient

  def text
    twilio_client.messages.create(
    :from => '+12898073438',
    :to => '+16478904632',
    :body => 'Hey there!'
  )
  end
end