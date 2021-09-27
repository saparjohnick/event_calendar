class AddIndexToUsersAndEventsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_index :events, [:user_id, :created_at]
  end
end
