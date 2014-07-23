class Job < ActiveRecord::Base
  validates :title, :source_lang, :target_lang, presence: true
  
  has_many :tasks
  
  belongs_to :customer, foreign_key: :customer_id, class_name: "User"
end
