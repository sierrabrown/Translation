class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      
      t.string :title
      t.string :description
      
      t.string :source_text
      t.string :macine_text
      t.string :target_text
      
      t.integer :customer_id
      t.integer :source_lang_id
      t.integer :target_lang_id
      
      t.boolean :completed
      t.integer :price
      

      t.timestamps
    end
  end
end
