# encoding : utf-8
class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@weekplan = @user.this_week
		@is_current_user = current_user == @user
	end

	def myfriends
		@user = current_user
		@is_current_user = current_user == @user
		@users = current_user.joined_friends
	end
end