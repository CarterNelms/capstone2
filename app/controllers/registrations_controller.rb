class RegistrationsController < Devise::RegistrationsController
  # before_filter :configure_permitted_parameters if :devise_controller
  # def create
  #   is_username_valid = false
  #   username = params[:user][:username]
  #   if username.length < 5
  #     flash.alert = "Username must be at least five (5) characters long"
  #   elsif username.length > 16
  #     flash.alert = "Username must be no more than sixteen (16) characters long"
  #   elsif username.gsub(/[^a-zA-Z0-9\s_-]/, '') != username
  #     flash.alert = "Username can contain letters, numbers, spaces, underscores (_) and dashes (-)"
  #   else
  #     is_username_valid = true        
  #     super
  #   end

  #   redirect_to (:back) if !is_username_valid
  # end

  # protected

  # def configure_permitted_parameters
  #   additional_attributes = [:username, :location]
  #   devise_parameter_sanitizer.for(:sign_up) << additional_attributes
  #   devise_parameter_sanitizer.for(:account_update) << additional_attributes
  # end
end