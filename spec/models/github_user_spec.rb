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

require 'spec_helper'

describe GithubUser do
  describe "validations" do
    it { should validate_presence_of :uid }
    it { should validate_presence_of :email }
    it { should validate_presence_of :oauth_token }
  end

  describe "associations" do
    it { should have_many :gists }
  end

  describe "mass assignment" do
    it { should allow_mass_assignment_of :email }

    it { should_not allow_mass_assignment_of :uid }
    it { should_not allow_mass_assignment_of :oauth_token }
    it { should_not allow_mass_assignment_of :remember_token }
    it { should_not allow_mass_assignment_of :name }
    it { should_not allow_mass_assignment_of :gravatar }
  end

  describe "#save" do
    it "creates a remember token" do
      user = FactoryGirl.build :github_user
      user.remember_token.should be_nil
      user.save!
      user.reload.remember_token.should_not be_nil
    end
  end
end
