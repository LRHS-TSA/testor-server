FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    description FFaker::Lorem.paragraph
  end
end
