# encoding : utf-8
class MainController < ApplicationController
  def home
    if user_signed_in?
      if current_user.this_week
        redirect_to myfriends_users_path
      else
        redirect_to new_user_weekplan_path(current_user)
      end
    end
  end
end
