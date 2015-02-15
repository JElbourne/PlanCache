FactoryGirl.define do
  factory :branch do
    subject "Test Subject"
    lower_subjects ["test subject"]
    cache_id ""
    user_id ""
    account_id ""
  end

end
