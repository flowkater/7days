class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.references :weekplan
      t.string :description
      t.integer :category_id
      t.boolean :todo_check

      t.timestamps
    end
    add_index :todos, :weekplan_id
  end
end
