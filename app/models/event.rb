class Event < ActiveRecord::Base
  has_many :votes
  belongs_to :user

  before_validation :add_university

  validate :start_time_greater_than_now

  geocoded_by :location   # can also be an IP address
  after_validation :geocode
  after_validation :determine_relevant
  after_validation :setup_text

  acts_as_taggable

  def start_time_greater_than_now
    if self.start_time < Time.current
      errors.add(:timeslot, "- must have at least one in event.")
    end
  end

  def setup_text
    $texter.delay(run_at: (self.start_time - 15.minutes)).send_event_notification(self.latitude, self.longitude, self.name, self.location, self.start_time, self.food_type)
  end

  def add_university
    self.location = self.location + " " + self.user.university
  end

  def determine_relevant
    if description
      sentences = description.split(/[.?!]/)
    else
      sentences = name.split(/[.?!]/)
    end
    relevant_sentences = 0
    food_types = []
    food_keywords = ["food", "drinks", "refreshments", "cookies", "juice", "cake", "snacks", "dinner", "lunch", "breakfast", "chocolate", "icecream", "ben and jerry", "oatmeal", "appetizer", "pie", "cupcake", "fruit", "coffee", "tea", "water", "juice", "wine", "booze", "alcohol", "beer", "cheese", "salad", "chicken wings", "fish", "eggs", "bread", "candy", "milk", "curry", "fish", "tarts", "strudel", "pizza", "pop", "chips", "salsa", "waffles", "pancakes", "soup", "frech toast", "fries", "poutine", "popcorn", "cotton candy", "popsicle", "banana", "apple", "sushi", "pasta", "watermelon", "hot chocolate", "butter chicken", "rice", "roti", "noodles", "ramen", "dumplings", "dim sum", "shawarma", "burritos"]
    require_keywords = ["provided", "free", "complimentary", "included"]

    sentences.each do |sentence|
      food_relevance = 0
      free_relevance = 0
      food_keywords.each do |kw|
        if sentence.downcase.include?(kw)
          food_types << kw
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