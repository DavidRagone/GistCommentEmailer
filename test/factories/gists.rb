# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gist do
    html_url "MyString"
    description "MyString"
    github_created_at "2013-02-02 14:31:12"
    github_updated_at "2013-02-02 14:31:12"
    comments 1
    public false
    id 1
    comments_url "MyString"
  end
end
