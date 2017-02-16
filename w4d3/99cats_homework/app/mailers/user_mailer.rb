class UserMailer < ApplicationMailer
  default from: 'everybody@appacademy.io'

  def welcome_email(user)
    @user = user
    @url = 'http://www.99cats.com'
    mail(to: user.username, subject: 'Welcome to 99cats!')
  end

end
