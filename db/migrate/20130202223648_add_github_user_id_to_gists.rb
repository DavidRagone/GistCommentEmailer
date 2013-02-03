class AddGithubUserIdToGists < ActiveRecord::Migration
  def change
    add_column :gists, :github_user_id, :integer
  end
end
