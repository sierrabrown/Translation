class AddEmails < ActiveRecord::Migration
  def change
    add_column :jobs, :email, :string
  end
end
