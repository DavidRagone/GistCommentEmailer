require "spec_helper"

describe GistMailer do
  describe "daily gist email" do
    let(:user) { FactoryGirl.create :github_user, :with_gist }
    let(:mail) { GistMailer.new_comments(user, user.gists) }

    it "renders the headers" do
      mail.subject.should eq "New comments on your gists"
      mail.from.should eq ["gistemailer@gmail.com"]
    end

    it "renders the body" do
      mail.body.encoded.lines.first.chomp.should eq "You have received "\
        "new comments on the following gists:"
    end
  end
end
