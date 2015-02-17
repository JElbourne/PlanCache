class Cache < ActiveRecord::Base
  
  belongs_to  :branch
  belongs_to  :message
  
  validates   :branch_id, presence: true
  validates   :message_id, presence: true
  validates   :files_json, presence: true
end
