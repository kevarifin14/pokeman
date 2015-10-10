class AddExperiencePointsToUser < ActiveRecord::Migration
  def change
    add_column :users, :experience_points, :decimal
  end
end
