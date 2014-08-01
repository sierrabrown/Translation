class GiveNewUsersMoney < ActiveRecord::Migration
  def change
    change_column :users, :funds, :integer, :default => 5
  end
end
