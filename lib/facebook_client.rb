module FacebookClient

  def facebook_client
    @graph = Koala::Facebook::API.new("1520469264863861|Ak7F-skJyuXA1TXBuLb4-qZU8Jg")
  end

  def query_string(society)
    facebook_client.get_page("#{society}/events?fields=name,description,location").each do |k,v|
      Event.create(name: k['name'], description: k['description'], start_time: k['start_time'], location: k['location'], user_id: 2)
    end
  end

  def get_events
    self.societies.each do |s|
      self.query_string(s)
    end
  end

  def societies
    ["appliedhealthsciencesundergraduatemembers", "arts.student.union", "sofa.uw", "uwengsoc", "UWESSociety", "mathsoc", "UWScienceSociety", "uwaterlooace", "UWACC", "youwillact", "uwaterlooasa", "UWARA", "uwapprentice", "uw.autosports", "uwblackjack", "c3inspire", "UWCabaret", "kwsalseros", "EngineersInMedicine", "UWEnglishTutors", "uwfa", "uWaterlooSororities", "UWHAPN", "uwhiphop", "hksa.uw", "UW.Improv", "UWIndianConnect", "KWChannelOne", "UWMeet", "UWmetal", "UWPSA", "UWPhotoClub", "p2c.waterloo", "UWPreRehabClub", "UWSFL", "sfpruw", "uwstylesoc", "uwaterlooswaggerloo", "UWVegeration", "UWWiSTEM"]
  end

end