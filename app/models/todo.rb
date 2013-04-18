class Todo < ActiveRecord::Base
	include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  belongs_to :weekplan
  attr_accessible :category_id, :description, :title, :todo_check
end
