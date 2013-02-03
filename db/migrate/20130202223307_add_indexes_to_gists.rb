class AddIndexesToGists < ActiveRecord::Migration
  def change
    add_column :gists, :github_id, :integer
    add_index :gists, :comments
    add_index :gists, :public
    add_index :gists, :github_id
  end
end
