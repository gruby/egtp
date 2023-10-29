class PasswordMailer < ApplicationMailer
  def password_reset
    mail to: params[:user].email
  end

  def registration_confirmation
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
