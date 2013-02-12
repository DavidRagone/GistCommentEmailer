FactoryGirl.define do
  factory :gist do
    github_updated_at { 1.day.ago }
    comments 1
    html_url 'https://gist.github.com/4242337'
    github_created_at { 2.days.ago }
    public true
    description 'words words words'
    github_id 4242337
    comments_url 'https://api.github.com/gists/4242337/comments'
  end

  trait :with_user do
    after(:create) do |gist, evaluator|
      gist.github_user = FactoryGirl.create :github_user
      gist.save!
    end
  end
end
