class Texter
  include TwilioClient

  def send_event_notification(latitude, longitude, name, location, start_time, food_type)
    body = "In 15 minutes: FREE #{food_type} at #{location} starting in 15 minutes. (Event name: #{name}) Get directions: https://www.google.com/maps?saddr=My+Location&daddr=#{latitude},#{longitude}"
    twilio_client.messages.create(
    :from => '+12898073438',
    :to => '+16478904632',
    :body => body
  )
  end
end