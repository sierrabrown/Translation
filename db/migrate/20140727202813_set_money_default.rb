class SetMoneyDefault < ActiveRecord::Migration
  def change
    change_column :users, :funds, :integer, default: 0
  end
end
