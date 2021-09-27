class AddNameAndPeriodToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :name, :string
    add_column :events, :period, :string
  end
end
