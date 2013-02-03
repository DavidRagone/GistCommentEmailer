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
#

class Gist < ActiveRecord::Base
  belongs_to :github_user

  attr_accessible :comments, :comments_url, :description, :github_created_at, :github_updated_at, :html_url, :github_id, :public
end
