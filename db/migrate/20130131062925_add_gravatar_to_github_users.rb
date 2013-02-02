class AddGravatarToGithubUsers < ActiveRecord::Migration
  def change
    add_column :github_users, :gravatar, :string
  end
end
