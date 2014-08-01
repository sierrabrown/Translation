class FiveDollarsNotFiveCents < ActiveRecord::Migration
  def change
    change_column :users, :funds, :integer, :default => 500
  end
end
