class Event < ActiveRecord::Base
  has_many :votes
  belongs_to :user

  before_validation :add_university

  geocoded_by :location   # can also be an IP address
  after_validation :geocode
  after_validation :determine_relevant

  acts_as_taggable


  def add_university
    self.location = self.location + " " + "Waterloo"
  end

  def determine_relevant
    if description
      sentences = description.split(/[.?!]/)
    else
      sentences = name.split(/[.?!]/)
    end
    relevant_sentences = 0
    food_keywords = ["food", "drinks", "refreshments", "cookies", "juice", "cake", "snacks", "dinner", "lunch", "breakfast", "chocolate", "icecream", "ben and jerry", "oatmeal", "appetizer", "pie", "cupcake", "fruit", "coffee", "tea", "water", "juice", "wine", "booze", "alcohol", "beer", "cheese", "salad", "chicken wings", "fish", "eggs", "bread", "candy", "milk", "curry", "fish", "tarts", "strudel", "pizza", "pop", "chips", "salsa", "waffles", "pancakes", "soup", "frech toast", "fries", "poutine", "popcorn", "cotton candy", "popsicle", "banana", "apple", "sushi", "pasta", "watermelon", "hot chocolate", "butter chicken", "rice", "roti", "noodles", "ramen", "dumplings", "dim sum", "shawarma", "burritos"]
    require_keywords = ["provided", "free", "complimentary", "included"]

    sentences.each do |sentence|
      food_relevance = 0
      free_relevance = 0
      food_keywords.each do |kw|
        if sentence.downcase.include?(kw)
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
  end
end