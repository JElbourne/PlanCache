FactoryGirl.define do
  factory :message do
    user_id SecureRandom.uuid
    account_id SecureRandom.uuid
    branch_id SecureRandom.uuid
    subject "Test Subject"
    email "fake@example.com"
  end

end
