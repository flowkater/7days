class ApplicationController < ActionController::Base
	include PublicActivity::StoreController
  protect_from_forgery
  helper_method :activities

  # get activities
  def activities
  	PublicActivity::Activity.order("created_at desc").limit(5)
  end
  
end
