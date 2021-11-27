class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = 'Access denied.'
    redirect_to root_url, alert: exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:name, :password) }
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :password) }

    # devise_parameter_sanitizer.permit(:account_update) do |u|
    #   u.permit(:name, :email, :bio, :photo, :password, :current_password)
    # end
  end
end
