class RemoveStartDateFromHabits < ActiveRecord::Migration[7.0]
  def change
    remove_column :habits, :start_date
  end
end
