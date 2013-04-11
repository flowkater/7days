class CreateWeekplans < ActiveRecord::Migration
  def change
    create_table :weekplans do |t|
      t.boolean :public_friends
      t.boolean :public_all
      t.references :user
      t.integer :progress_rate

      t.timestamps
    end
    add_index :weekplans, :user_id
  end
end
