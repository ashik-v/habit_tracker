class CreateHabits < ActiveRecord::Migration[7.0]
  def change
    create_table :habits do |t|
      t.string :name
      t.date :start_date
      t.text :tracked_dates

      t.timestamps
    end
  end
end
