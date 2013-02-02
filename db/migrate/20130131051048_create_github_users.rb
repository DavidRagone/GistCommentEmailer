class CreateGithubUsers < ActiveRecord::Migration
  def change
    create_table :github_users do |t|
      t.string :uid
      t.string :email
      t.string :oauth_token
      t.string :remember_token

      t.timestamps
    end
  end
end
