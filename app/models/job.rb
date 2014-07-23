class Job < ActiveRecord::Base
  validates :title, :source_lang_id, :target_lang_id, presence: true
  
  has_many :tasks
  
  belongs_to :customer, foreign_key: :customer_id, class_name: "User"
end
