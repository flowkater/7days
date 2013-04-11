# encoding: UTF-8
class WeekplansController < ApplicationController

  before_filter :authenticate_user!, only: [:new]

	def index
    @weekplans = Weekplan.find_all_by_user_id(current_user.id)   
  end

  def new
    @user = current_user
    @is_current_user = current_user == @user
    @weekplan = current_user.this_week
    if @weekplan.blank?
      @weekplan = current_user.weekplans.build
    else
      redirect_to edit_weekplan_path(@weekplan), notice: '이번주 계획을 이미 생성하셨습니다.'
    end
  end

  def edit
    if Weekplan.currentuser_this_week(current_user.id)
      @weekplan = Weekplan.currentuser_this_week(current_user.id)
    else
      redirect_to new_weekplan_path, notice: "You don't have Schedule this week"
    end
  end

	def show
    @weekplan = Weekplan.find(params[:id])
  end

  def create
    @weekplan = current_user.weekplans.new(params[:weekplan])

    respond_to do |format|
      if @weekplan.save
        redirect_to @weekplan, notice: 'Weekplans was successfully created.'
      else
        render action: "new"
      end
    end
  end

  def update
    @weekplan = Weekplan.currentuser_this_week(current_user.id)

    respond_to do |format|
      if @weekplan.first.update_attributes(params[:weekplan])
        redirect_to @weekplan, notice: 'Weekplan was successfully updated.'
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @weekplan = Weekplan.currentuser_this_week(current_user.id)
    @weekplan.destroy
    redirect_to weekplans_url
  end
end
