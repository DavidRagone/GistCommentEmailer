class RenamePreviousCommentsAndChangeToBoolean < ActiveRecord::Migration
  def up
    remove_column :gists, :previous_comments
    add_column :gists, :new_comments, :boolean
  end

  def down
    remove_column :gists, :new_comments
    add_column :gists, :previous_comments, :integer
  end
end
