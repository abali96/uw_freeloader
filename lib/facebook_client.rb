module FacebookClient

  def facebook_client
    @graph = Koala::Facebook::API.new("1520469264863861|Ak7F-skJyuXA1TXBuLb4-qZU8Jg")
  end

  def query_string(society)
    facebook_client.get_page("#{society}/events?fields=name,description,location").each do |k,v|
      Event.create(name: k['name'], description: k['description'], start_time: k['start_time'], location: k['location'], user_id: User.find_by_email("foodbot@uwaterloo.ca").id)
    end
  end

  def get_events
    self.societies.each do |s|
      self.query_string(s)
    end
  end

  def societies
    ["uwengsoc", "mathsoc"]
  end

end