class ChangeGistsNewCommentsToInt < ActiveRecord::Migration
  def up
    remove_column :gists, :new_comments
    add_column :gists, :new_comments, :integer
  end

  def down
    remove_column :gists, :new_comments
    add_column :gists, :new_comments, :boolean
  end
end
