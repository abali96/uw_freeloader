class User < ActiveRecord::Base
  has_many :events
  has_many :votes
  # has_secure_password
  # phony_normalize :phone_number
  validate :phone_number, length: { is: 10 }


  def login
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      give_token
    else
      redirect_to home_url
    end
  end
end