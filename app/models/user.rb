class User < ActiveRecord::Base
  has_many :events
  has_many :votes
  # has_secure_password
  validates :phone_number, length: { is: 10 }
  validates :phone_number, uniqueness: true
  after_validation :welcome

  include TwilioClient

  def login
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      give_token
    else
      redirect_to home_url
    end
  end

  def welcome
    $texter.send_welcome_text(self.phone_number)
  end
end