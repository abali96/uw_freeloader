namespace :events do
  desc "Rake task to get events data"
  task :get => :environment do
    include FacebookClient
    get_events
    puts "#{Time.now} - Success!"
  end
end