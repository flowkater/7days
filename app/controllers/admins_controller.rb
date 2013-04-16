class AdminsController < Devise::SessionsController
	def after_sign_in_path_for(resource)
	  admins_path
	end

  def index
    
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

  def show_users
  	@users = User.all
  end

  def show_weekplans
  	@weekplans = Weekplan.all
  end
end