# encoding : utf-8
class UsersController < ApplicationController

	before_filter :authenticate_user!, only: [:myfriends]

	# /users/:id - users_path(user)
	def show
		@user = User.find(params[:id])
		@weekplan = @user.this_week
		@is_current_user, @friends = is_user_and_joined_friends
	end

	# /users/myfriends - myfriends_users_path
	def myfriends
		@user = current_user
		@is_current_user, @users = is_user_and_joined_friends
	end

	private 

	def is_user_and_joined_friends
		return current_user == @user, current_user.joined_friends
	end
end