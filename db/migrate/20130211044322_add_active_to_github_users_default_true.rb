class AddActiveToGithubUsersDefaultTrue < ActiveRecord::Migration
  def change
    add_column :github_users, :active, :boolean, default: true
  end
end
