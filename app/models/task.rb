class Task < ActiveRecord::Base
  belongs_to :translator, foreign_key: :translator_id, class_name: "User"
end
