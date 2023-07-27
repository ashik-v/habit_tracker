task backfill_deprecated_tracked_dates: [:environment] do
  puts "starting backfill..."
  Habit.in_batches(of: 1000).each_record do |habit|
    habit.update!(deprecated_tracked_dates: habit.tracked_dates)
  end
  puts "backfill completed..."
end
