class Task < ActiveRecord::Base
  validates :source_text, :machine_text, :source_lang, :target_lang, :presence => true
  
  belongs_to :translator, foreign_key: :translator_id, class_name: "User"
end
