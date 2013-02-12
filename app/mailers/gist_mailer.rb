class GistMailer < ActionMailer::Base
  default from: "gistemailer@gmail.com"

  def new_comments(user, gists)
    @user = user
    @gists = gists

    mail to: user.email, subject: "New comments on your gists"
  end
end
