class Event < ActiveRecord::Base
  has_many :votes
  belongs_to :user

  before_validation :add_university

  geocoded_by :location   # can also be an IP address
  after_validation :geocode

  acts_as_taggable

  def add_university
    self.location = self.location + " " + self.user.university
  end
end
