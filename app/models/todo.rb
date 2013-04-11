class Todo < ActiveRecord::Base
  belongs_to :weekplan
  attr_accessible :category_id, :description, :title, :todo_check
end
