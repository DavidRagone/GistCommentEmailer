class AddIndexesToGithubUsers < ActiveRecord::Migration
  def change
    add_index :github_users, :uid
    add_index :github_users, :oauth_token
  end
end
