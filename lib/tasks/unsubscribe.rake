namespace :users do
  desc "Rake task to get events data"
  task :unsubscribe => :environment do
    include TwilioClient
    twilio_client
    @client.account.messages.list({:to => "+12898073438"}).each do |x|
      if x.body.downcase.include?("iwanttopay")
        x = x.from[2..-1]
        if !User.where("phone_number = ?", x).empty?
          $texter.send_unsubscribe_text(x)
          puts "#{x} is about to be removed"
          User.find_by_phone_number(x).delete
        end
      end
    end
    puts "#{Time.now} - Success!"
  end
end