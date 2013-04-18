# encoding: UTF-8
class WeekplansController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :edit, :create, :update]
  
  def new
    @user = current_user
    @is_current_user = current_user == @user
    @weekplan = current_user.this_week
    @activities = PublicActivity::Activity.order("created_at desc")
    if @weekplan.blank?
      @weekplan = current_user.weekplans.build
    else
      redirect_to edit_user_weekplan_path(current_user, @weekplan), notice: '이번주 계획을 이미 생성하셨습니다.'
    end
  end

  def edit
    @user = current_user
    @is_current_user = current_user == @user
    @activities = PublicActivity::Activity.order("created_at desc")
    if @weekplan = current_user.this_week
      
    else
      redirect_to new_user_weekplan_path, notice: "You don't have Schedule this week"
    end
  end

  def create
    @weekplan = current_user.weekplans.new(params[:weekplan])

    if @weekplan.save
      redirect_to user_path(current_user), notice: "이번주 계획이 생성되었습니다!"
    else
      render action: "new"
    end
  end

  def update
    @weekplan = current_user.this_week

    if @weekplan.update_attributes(params[:weekplan])
      redirect_to user_path(current_user), notice: 'Weekplan was successfully updated.'
    else
      render action: "edit"
    end
  end
end
