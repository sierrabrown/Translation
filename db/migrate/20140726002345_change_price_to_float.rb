class ChangePriceToFloat < ActiveRecord::Migration
  def change
    change_column :jobs, :price, :float
  end
end
