class AddNotificationsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :notifications, :boolean, default: false
  end
end
