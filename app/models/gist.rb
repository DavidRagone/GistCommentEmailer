# == Schema Information
#
# Table name: gists
#
#  id                :integer          not null, primary key
#  html_url          :string(255)
#  description       :string(255)
#  github_created_at :datetime
#  github_updated_at :datetime
#  comments          :integer
#  public            :boolean
#  comments_url      :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  github_id         :integer
#  github_user_id    :integer
#  new_comments      :integer
#

class Gist < ActiveRecord::Base
  belongs_to :github_user

  attr_accessible :comments, :comments_url, :description, :github_created_at, :github_updated_at, :html_url, :github_id, :public

  before_save :update_new_comments

private
  def update_new_comments
    self.new_comments = comments - comments_was.to_i
    self.github_user.has_new_comments! if new_comments > 0 && github_user
  end
end
