class ApplicationController < ActionController::Base
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:name, :password) }
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :password) }

    # devise_parameter_sanitizer.permit(:account_update) do |u|
    #   u.permit(:name, :email, :bio, :photo, :password, :current_password)
    # end
  end
end
