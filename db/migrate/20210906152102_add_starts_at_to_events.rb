class AddStartsAtToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :starts_at, :text
  end
end
