class AddHasNewCommentsToGithubUser < ActiveRecord::Migration
  def change
    add_column :github_users, :has_new_comments, :boolean, default: false
  end
end
