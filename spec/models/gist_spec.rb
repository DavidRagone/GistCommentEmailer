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
    it { should_not allow_mass_assignment_of :new_comments }
  end

  describe "save" do
    context "new" do
      let(:gist) { FactoryGirl.build :gist }
      it "sets new_comments to number of comments" do
        gist.stub_chain(:github_user, :has_new_comments!)
        gist.save
        gist.new_comments.should eq 1
      end

      it "sets users's has_new_comments to true" do
        gist.github_user = FactoryGirl.create :github_user
        gist.save
        gist.github_user.has_new_comments.should eq true 
      end
    end

    context "update" do
      let(:gist) { FactoryGirl.create :gist }

      context "no new comments" do
        it "sets new_comments to diff of comments count" do
          gist.stub_chain(:github_user, :has_new_comments!)
          gist.description = "New description"
          gist.save!
          Gist.first.new_comments.should eq 0
        end
      end
    end
  end
end
