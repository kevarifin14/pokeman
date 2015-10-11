class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :strength, :decimal
    add_column :users, :endurance, :decimal
    add_column :users, :speed, :decimal
    add_column :users, :balance, :decimal
    add_column :users, :agility, :decimal
  end
end
