class AddPreviousCommentsToGists < ActiveRecord::Migration
  def change
    add_column :gists, :previous_comments, :integer
  end
end
