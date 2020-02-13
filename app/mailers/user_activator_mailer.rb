class UserActivatorMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: 'Activate your account.')
  end
end
