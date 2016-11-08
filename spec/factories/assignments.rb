FactoryGirl.define do
  factory :assignment do
    sequence(:name) { |n| "Assignment #{n}" }
    association :group
    association :test
    start_date nil
    end_date nil
    length nil
  end
end
