class DefaultIncludePrivateGistsToTrueOnGithubUsers < ActiveRecord::Migration
  def up
    change_column :github_users, :include_private_gists, :boolean, default: true
  end

  def down
    change_column :github_users, :include_private_gists, :boolean
  end
end
