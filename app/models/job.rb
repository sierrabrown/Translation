class Job < ActiveRecord::Base
  validates :title, :source_lang_id, :target_lang_id, presence: true
  
  has_many :tasks
  
  belongs_to :customer, foreign_key: :customer_id, class_name: "User"
  
  def print
    p "delayed jobs worked"
  end
end
