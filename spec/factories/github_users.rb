FactoryGirl.define do
  factory :github_user do
    uid { rand 99 }
    email 'test@example.com'
    oauth_token { rand 999 }
  end
end
