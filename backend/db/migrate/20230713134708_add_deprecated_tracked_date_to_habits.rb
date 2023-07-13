class AddDeprecatedTrackedDateToHabits < ActiveRecord::Migration[7.0]
  def change
    add_column :habits, :deprecated_tracked_dates, :text
  end
end
