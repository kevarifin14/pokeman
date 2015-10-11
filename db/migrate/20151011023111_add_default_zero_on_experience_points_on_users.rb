class AddDefaultZeroOnExperiencePointsOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :experience_points, :decimal, default: 0
  end
end
