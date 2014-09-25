class RegistrationsController < Devise::RegistrationsController
  def create
    is_username_valid = false
    username = params[:user][:username]
    if username.length < 5
      flash.alert = "Username must be at least five (5) characters long"
    elsif username.length > 16
      flash.alert = "Username must be no more than sixteen (16) characters long"
    elsif username.gsub(/[^a-zA-Z0-9\s_-]/, '') != username
      flash.alert = "Username can contain letters, numbers, spaces, underscores (_) and dashes (-)"
    else
      is_username_valid = true        
      super
      set_resource_location
      resource.username = username
      resource.save
    end

    redirect_to (:back) if !is_username_valid
  end

  def update
    new_account_update_params = account_update_params.merge! location: params[:user][:location]
    account_update_params = new_account_update_params

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
        :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end

    # super()

    # new_account_update_params = account_update_params.merge! location: params[:user][:location]
    # account_update_params = new_account_update_params
    # update_resource(resource, account_update_params)


    # super

    # set_resource_location
    # puts params[:user][:password]
    # resource.update(location: params[:user][:location]) if 
    # resource_updated = update_resource(resource, account_update_params.merge!( location: params[:user][:location] ))
    # set_resource_location
    # resource.save
  end

  def set_resource_location
    resource.location = params[:user][:location]
  end
end