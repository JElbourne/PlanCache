FactoryGirl.define do
  factory :user do
    provider 'facebook'
    sequence(:uid) { |n| "1234567#{n}" }
    
    sequence(:nickname) { |n| "jbloggs#{n}" }
    sequence(:email) { |n| "joe#{n}@bloggs.com" }
    sequence(:name) { |n| "Joe#{n} Bloggs" }
    sequence(:first_name) { |n| "Joe#{n}" }
    last_name 'Bloggs'
    location 'Palo Alto, California'
  end
end