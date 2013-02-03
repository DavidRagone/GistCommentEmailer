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
#  include_private_gists :boolean
#

class GithubUser < ActiveRecord::Base
  validates_presence_of :uid, :oauth_token, :email
  has_many :gists

  before_save :create_remember_token
  attr_accessible :email

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
