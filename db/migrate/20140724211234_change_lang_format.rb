class ChangeLangFormat < ActiveRecord::Migration
  def change
    change_column :jobs, :source_lang, :string
    change_column :jobs, :target_lang, :string
  end
end
