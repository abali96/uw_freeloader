class Texter
  include TwilioClient

  def send_event_notification(latitude, longitude, name, location, start_time, food_type)
    User.where.not(phone_number: nil).each do |user|
      body = "In 15 minutes: FREE #{food_type} at #{location} starting at #{start_time.strftime('%I:%M %p')}. (Event name: #{name}) Get directions: http://www.google.com/maps?saddr=My+Location&daddr=#{latitude},#{longitude}"
      twilio_client.messages.create(
      :from => '+12898073438',
      :to => user.phone_number,
      :body => body
      )
    end
  end
end