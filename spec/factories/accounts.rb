FactoryGirl.define do
  factory :account do
    name "MyString"
    key SecureRandom.uuid
  end

end
