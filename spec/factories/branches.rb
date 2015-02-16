FactoryGirl.define do
  factory :branch do
    subject "This is an example webhook message"
    lower_subjects ["this is an example webhook message"]
    cache_id ""
    user_id ""
    account_id ""
  end

end
