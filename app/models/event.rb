class Event < ActiveRecord::Base
  has_many :votes
  belongs_to :user

  before_validation :add_university

  validate :start_time_greater_than_now
  validates :name, :uniqueness => {:scope => [:start_time, :location]}

  geocoded_by :location   # can also be an IP address
  after_validation :geocode
  after_validation :determine_relevant
  after_validation :setup_text
  after_validation :update_keywords

  acts_as_taggable

  def start_time_greater_than_now
    if self.start_time < (Time.current - 5.minutes)
      errors.add(:timeslot, "- must have at least one in event.")
    end
  end

  def setup_text
    $texter.delay(run_at: (self.start_time - 15.minutes)).send_event_notification(self.latitude, self.longitude, self.name, self.location, self.start_time.utc - 4.hours, self.food_type)
  end

  def update_keywords
    $redis.sadd('food_keywords', food_type.split(', '))
  end

  def add_university
    self.location = self.location + " " + "Waterloo"
  end

  def determine_relevant
    relevant_sentences = 0
    food_types = []
    food_keywords = $redis.smembers("food_keywords")
    require_keywords = ["provided", "free", "complimentary", "included"]

    sentences = if description
      description.split(/[.?!]/)
    else
      name.split(/[.?!]/)
    end

    sentences.each do |sentence|
      food_relevance = 0
      free_relevance = 0
      food_keywords.each do |kw|
        if sentence.downcase.include?(kw)
          food_keywords << food_types
          food_relevance += 1
        end
      end
      if food_relevance > 0
        require_keywords.each do |kw|
          if sentence.downcase.include?(kw)
            free_relevance += 1
          end
        end
      end
      if free_relevance > 0
        relevant_sentences += 1
      end
    end
    self.update_attribute(:relevant, relevant_sentences)
    food_types = food_types.uniq.join(', ')
    if !self.food_type || self.food_type.empty?
      self.update_attribute(:food_type, food_types)
    end

  end
end