class ChangeSubmissionFormat < ActiveRecord::Migration
    def change
      change_column :jobs, :source_text, :text
      change_column :jobs, :source_text, :text
    end
end
