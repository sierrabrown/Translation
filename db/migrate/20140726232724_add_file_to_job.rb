class AddFileToJob < ActiveRecord::Migration
  def change
    add_attachment :jobs, :translated_file
  end
end
