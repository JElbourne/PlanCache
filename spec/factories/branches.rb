FactoryGirl.define do
  factory :branch do
    subject "This is an example webhook message"
    lower_subjects ["this is an example webhook message"]
    cache_id SecureRandom.uuid
    user_id SecureRandom.uuid
    account_id SecureRandom.uuid
  end

end
