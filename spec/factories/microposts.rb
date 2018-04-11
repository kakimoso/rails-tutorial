FactoryGirl.define do
  factory :micropost do
    content "test post"
    association :user
  end
end
