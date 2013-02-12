FactoryGirl.define do
  factory :github_user do
    uid { "#{rand 99}" }
    email 'test@example.com'
    name 'bob'
    oauth_token { "#{rand 999}" }

    trait :inactive do
      before(:create) do |github_user, evaluator|
        github_user.active = false
      end
    end

    trait :new_comments do
      before(:create) do |github_user, evaluator|
        github_user.has_new_comments = true
      end
    end

    trait :with_gist do
      after(:create) do |github_user, evaluator|
        github_user.gists.create!(
          github_updated_at: 2.day.ago,
          comments: 0,
          html_url: 'https://gist.github.com/4242337',
          github_created_at: 2.days.ago,
          public: true,
          description: 'words words words',
          github_id: 4242337,
          comments_url: 'https://api.github.com/gists/4242337/comments'
        )
      end
    end

    trait :with_commented_gist do
      after(:create) do |github_user, evaluator|
        github_user.gists.create!(
          github_updated_at: 2.day.ago,
          comments: 1,
          html_url: 'https://gist.github.com/4242337',
          github_created_at: 2.days.ago,
          public: true,
          description: 'words words words',
          github_id: 123456,
          comments_url: 'https://api.github.com/gists/123456/comments'
        )
      end
    end
  end
end
