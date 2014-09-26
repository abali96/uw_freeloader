class Texter
  include TwilioClient

  def send_event_notification(latitude, longitude, name, location, start_time, food_type)
    User.where.not(phone_number: nil).each do |user|
      body = "Free #{food_type} at #{location} starting at #{start_time.strftime('%I:%M %p')} (15 minutes from now) | Event: #{name} | Get directions: http://www.google.com/maps?saddr=My+Location&daddr=#{latitude},#{longitude}"
      twilio_client.messages.create(
      :from => '+12898073438',
      :to => user.phone_number,
      :body => body
      )
    end
  end

  def send_welcome_text(phone_number)
    body = "Welcome to Waterloo Freeloader! We promise we won't spam, but if at any time you'd like to unsubscribe, reply with 'IWantToPay'."
    twilio_client.messages.create(
    :from => '+12898073438',
    :to => phone_number,
    :body => body
    )
  end

  def unsubscribe
    twilio_client
    @client.account.messages.list({:to => "+12898073438"}).each do |x|
      if x.body.downcase.include?("iwanttopay")
        x = x.from[2..-1]
        if !User.where("phone_number = ?", x).empty?
          $texter.send_unsubscribe_text(x)
          User.find_by_phone_number(x).delete
        end
      end
    end
  end

  def send_unsubscribe_text(phone_number)
    body = "I guess you don't want free food :("
    twilio_client.messages.create(
    :from => '+12898073438',
    :to => phone_number,
    :body => body
    )
  end
end