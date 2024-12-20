class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json
  
  # before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last

    if token.blank?
      render json: { error: 'Authorization token missing' }, status: :unauthorized
    else
      begin
        jwt_secret = '55964cb2c930b9d0139a0998ff7b73433e138d7680dfdd6260d6374d175b2da0d10aed87615705faa12a43daa1427156e959d8830f80f49610c8895a5fd39c12'

        decoded_token = JWT.decode(token, jwt_secret, true, { algorithm: 'HS256' })
        user_id = decoded_token[0]['user_id']
        @current_user = User.find(user_id)
      rescue JWT::DecodeError => e
        render json: { error: 'Invalid token', message: e.message }, status: :unauthorized
      end
    end
  end

  # Makes @current_user accessible
  def current_user
    @current_user
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  end
end

