class ReferralMailer < ApplicationMailer
  def invitation_email(user, recipient_email)
    @user = user
    @signup_url = "http://localhost:3001/signup"
    
    mail(
      to: recipient_email,
      subject: "#{@user.email} has invited you to join our platform"
    )
  end
end