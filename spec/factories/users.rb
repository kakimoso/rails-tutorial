FactoryGirl.define do
  factory :user, aliases: [:owner] do
    name "Example User"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    activated true
    
    trait :invalid_user do
      password nil
    end
  end
  
  # 既存と重複しない管理者ユーザ
  factory :loginuser, class: User do
    name "test user"
    email "test@testemail.com"
    password              "password"
    password_confirmation "password"
    admin     true
    activated true
    activated_at Time.zone.now
    
    trait :non_admin do
      admin false
    end
    
  end

end
