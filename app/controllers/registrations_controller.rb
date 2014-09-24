class RegistrationsController < Devise::RegistrationsController
  def create
    super
    resource.location = params[:user][:location]
    if !resource.location.empty?
      geocoder_location = Geocoder.search(resource.location).first
      resource.latitude = geocoder_location.latitude
      resource.longitude = geocoder_location.longitude
    end
    resource.save
  end
end