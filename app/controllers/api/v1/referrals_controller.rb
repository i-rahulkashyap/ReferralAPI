class Api::V1::ReferralsController < ApplicationController
  # before_action :authenticate_api_v1_user!  # Ensure the user is authenticated

  class Api::V1::ReferralsController < ApplicationController
    def create
      email = params[:email]
  
      if email.present? && email.match?(URI::MailTo::EMAIL_REGEXP)
        if email == current_user.email
          render json: { error: 'You cannot refer yourself' }, status: :unprocessable_entity
        elsif User.exists?(email: email)
          render json: { error: 'User with this email already exists' }, status: :unprocessable_entity
        else
          ReferralMailer.invitation_email(current_user, email).deliver_later
          render json: { message: 'Referral email sent successfully' }, status: :ok
        end
      else
        render json: { error: 'Invalid email address' }, status: :unprocessable_entity
      end
    end
  end
end

