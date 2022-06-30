class RemoveStartDateFromHabits < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :habits, :start_date }
  end
end
