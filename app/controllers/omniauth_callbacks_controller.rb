# encoding: UTF-8
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		# raise request.env["omniauth.auth"].to_yaml
		user = User.from_omniauth(request.env["omniauth.auth"])
		if user.persisted? 
			flash.notice = "로그인 되었습니다."
      	sign_in_and_redirect user
		else
			session["devise.user_attributes"] = user.attributes
			redirect_to new_user_registration_url
		end
	end	
end
