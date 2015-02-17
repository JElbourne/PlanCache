class Branch < ActiveRecord::Base
  belongs_to  :user
  has_many    :messages
  has_many    :caches
  
  validates :subject, presence: true
  validates :user_id, presence: true
  validates :account_id, presence: true
  
  def self.get_from_subject(subject, user_id, account_id)
    where("lower_subjects @> ?", "{#{subject.try(:downcase)}}").first_or_create do |b|
      b.subject = subject
      b.lower_subjects = [subject.downcase!]
      b.user_id = user_id
      b.account_id = account_id
      logger.debug "\n\nCreating Branch\n\n"
    end
  end
  
end
