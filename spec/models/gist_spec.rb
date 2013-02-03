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

require 'spec_helper'

describe Gist do
  describe "validations" do
  end

  describe "assocations" do
    it { should belong_to :github_user }
  end

  describe "mass assignment" do
    it { should allow_mass_assignment_of :html_url }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :github_created_at }
    it { should allow_mass_assignment_of :github_updated_at }
    it { should allow_mass_assignment_of :comments }
    it { should allow_mass_assignment_of :public }
    it { should allow_mass_assignment_of :comments_url }
    it { should allow_mass_assignment_of :github_id }

    it { should_not allow_mass_assignment_of :github_user_id }
  end
end
