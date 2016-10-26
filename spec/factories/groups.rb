FactoryGirl.define do
  factory :group do
    name FFaker::Education.school_name
    description FFaker::Lorem.paragraph
  end
end
