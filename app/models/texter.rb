class Texter
  include TwilioClient

  def send_event_notification()
    twilio_client.messages.create(
    :from => '+12898073438',
    :to => '+16478904632',
    :body => 'In 15 minutes: FREE  '
  )
  end
end