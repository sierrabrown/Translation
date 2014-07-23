class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :job_id

      t.string :source_text
      t.string :macine_text
      t.string :target_text
      
      t.integer :translator_id
      t.integer :source_lang_id
      t.integer :target_lang_id
      
      t.boolean :completed
      t.integer :price

      t.timestamps
    end
  end
end
