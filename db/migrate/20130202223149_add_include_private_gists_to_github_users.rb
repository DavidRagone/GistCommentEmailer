class AddIncludePrivateGistsToGithubUsers < ActiveRecord::Migration
  def change
    add_column :github_users, :include_private_gists, :boolean
  end
end
