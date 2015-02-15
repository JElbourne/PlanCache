class Account < ActiveRecord::Base
  
  belongs_to :user
  has_many :branches
  
  validates :name, presence: true
  validates :key, presence: true
   
end
