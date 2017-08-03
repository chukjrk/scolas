class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from 'TypeError' do
    flash[:danger] = "you do not have any interests. Add some in your account page!"
    redirect_to :back
  end

  def after_sign_up_path_for(resource)
    interest_index_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    interest_index_path(resource)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :interests, :first_name, :last_name, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :interests])
  end
end

# if you don't want to bundle update, replace this with the sanitizers inside configure_permitted_parameters

# devise_parameter_sanitizer.for(:sign_up) << :name, :interests
# devise_parameter_sanitizer.for(:account_update) << :name, :interests
