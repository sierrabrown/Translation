class AddWordsPurchasedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :words_purchased, :integer, default: 0
  end
end
