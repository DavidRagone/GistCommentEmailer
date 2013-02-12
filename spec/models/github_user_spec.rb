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
    it { should allow_mass_assignment_of :active }

    it { should_not allow_mass_assignment_of :include_private_gists }
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

  describe '#active' do
    let(:user) { FactoryGirl.build :github_user }
    it 'defaults to true' do
      user.save
      user.reload.active.should eq true
    end
  end

  describe "#has_new_comments!" do
    let(:user) { FactoryGirl.create :github_user }
    it "changes user.has_new_comments to true" do
      user.has_new_comments.should be false
      user.has_new_comments!
      user.reload.has_new_comments.should be true
    end
  end

  describe "scopes" do
    describe "#gists" do
      describe "#with_new_comments" do
        let!(:user) { FactoryGirl.create :github_user, :with_commented_gist, :with_gist }

        it "returns the commented gist" do
          user.gists.with_new_comments.should include Gist.find_by_github_id(123456)
          user.gists.with_new_comments.count.should be 1
        end
      end
    end

    describe "#actives" do
      let!(:user_1) { FactoryGirl.create :github_user }
      let!(:user_2) { FactoryGirl.create :github_user, :inactive }

      it "returns only active users" do
        GithubUser.actives.should include user_1
        GithubUser.actives.should_not include user_2
      end
    end

    describe "#have_new_comments" do
      let!(:user_1) { FactoryGirl.create :github_user }
      let!(:user_2) { FactoryGirl.create :github_user, :inactive }
      let!(:user_3) { FactoryGirl.create :github_user, :new_comments }

      it "returns only active users with new_comments" do
        GithubUser.have_new_comments.should include user_3
        GithubUser.have_new_comments.should_not include user_1
        GithubUser.have_new_comments.should_not include user_2
      end
    end
  end

  describe "gists" do
    describe ".create_from_hashie_mash" do
      let(:user) { FactoryGirl.create :github_user }
      let(:new_gist) { [Hashie::Mash.new(
        updated_at: 1.day.ago,
        comments: 1,
        html_url: 'https://gist.github.com/4242337',
        created_at: 2.days.ago,
        public: true,
        description: 'words words words',
        id: 4242337,
        comments_url: 'https://api.github.com/gists/4242337/comments'
        )]
      }

      context 'when the user has no prior gists' do
        it 'creates new gists' do
          expect { user.gists.create_from_hashie_mash(new_gist) }
            .to change(Gist, :count).by(1)
        end

        it 'creates a gist belonging to the user' do
          user.gists.create_from_hashie_mash(new_gist)
          Gist.first.github_user.should eq user
        end
      end

      context 'when the user has prior gists' do
        let!(:user) { FactoryGirl.create :github_user, :with_gist }

        context 'that match the new gists' do
          it 'does not create a new gist' do
            expect { user.gists.create_from_hashie_mash(new_gist) }
              .not_to change(Gist, :count)
          end

          it 'updates the existing gist' do
            Gist.first.comments.should eq 0
            user.gists.create_from_hashie_mash(new_gist)
            Gist.first.comments.should eq 1
          end
        end

        context 'that do not match the new gists' do
          let(:gist) { [Hashie::Mash.new(
            updated_at: 1.day.ago,
            comments: 2,
            html_url: 'https://gist.github.com/1234',
            created_at: 1.days.ago,
            public: false,
            description: 'words words words',
            id: 1234,
            comments_url: 'https://api.github.com/gists/1234/comments'
            )]
          }

          it 'creates new gists' do
            expect { user.gists.create_from_hashie_mash(gist) }
              .to change(Gist, :count).by(1)
          end

          it 'creates a gist belonging to the user' do
            user.gists.create_from_hashie_mash(gist)
            Gist.first.github_user.should eq user
          end
        end
      end
    end
  end
end
