namespace :events do
  desc "Rake task to get events data"
  task :get => :environment do
    include FacebookClient
    u = User.find_by_email("foodbot@uwaterloo.ca").id
    Event.where('user_id = ?', u).delete_all
    get_events
    puts "DONE GETTING EVENTS #{Time.now} - Success!"
  end
end