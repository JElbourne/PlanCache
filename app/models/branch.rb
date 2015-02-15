class Branch < ActiveRecord::Base
  belongs_to  :user
  has_many    :messages
  
  def self.get_from_subject(subject)
    where("lower_subjects @> ?", "{#{subject.try(:downcase)}}").first_or_create do |b|
      b.lower_subjects = [subject.downcase!]
    end
  end
  
end
