FactoryGirl.define do
  factory :cach, :class => 'Cache' do
    branch_id SecureRandom.uuid
    parent_cache SecureRandom.uuid
    files_json {}
  end

end
