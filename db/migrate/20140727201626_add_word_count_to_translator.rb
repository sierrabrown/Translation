class AddWordCountToTranslator < ActiveRecord::Migration
  def change
    add_column :users, :wordCount, :integer, default: 0
  end
end
