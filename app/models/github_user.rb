# == Schema Information
#
# Table name: github_users
#
#  id                    :integer          not null, primary key
#  uid                   :string(255)
#  email                 :string(255)
#  oauth_token           :string(255)
#  remember_token        :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  name                  :string(255)
#  gravatar              :string(255)
#  include_private_gists :boolean          default(TRUE)
#  active                :boolean          default(TRUE)
#  has_new_comments      :boolean          default(FALSE)
#

class GithubUser < ActiveRecord::Base
  validates_presence_of :uid, :email, :oauth_token

  has_many :gists do
    def with_new_comments
      where('new_comments > 0')
    end

    def create_from_hashie_mash(mashes)
      mashes.each do |mash|
        where(github_id: mash.id).first_or_initialize.tap do |gist|
          gist.comments = mash.comments
          gist.comments_url = mash.comments_url
          gist.description = mash.description
          gist.github_created_at =  mash.created_at
          gist.github_updated_at =  mash.updated_at
          gist.html_url = mash.html_url
          gist.github_id = mash.id
          gist.public =  mash.public
          gist.save!
        end
      end
    end
  end

  before_save :create_remember_token
  attr_accessible :email, :active

  scope :actives, where(active: true)
  scope :have_new_comments, actives.where(has_new_comments: true)

  def has_new_comments!
    self.has_new_comments = true
    save
  end

  def self.from_oauth(auth)
    where(uid: auth.uid.to_s).first_or_initialize.tap do |user|
      user.uid = auth.uid
      user.name = auth.info.name
      if auth.info.email.empty? && user.email.nil?
        user.email = user.name
      else
        user.email = user.email || auth.info.email
      end
      user.gravatar = auth.info.image
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end

private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
