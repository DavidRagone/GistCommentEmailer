class SessionsController < ApplicationController
  def create
    sign_in_user_from_github_credentials

    ask_for_email if missing_user_email?

    redirect_to edit_github_user_path(@user)
  end

  def destroy
    sign_out
    redirect_to root_url
  end

private
  def sign_in_user_from_github_credentials
    @user = GithubUser.from_oauth(env['omniauth.auth'])
    sign_in @user
  end

  def missing_user_email?
    @user.email == @user.name
  end

  def ask_for_email
    flash[:alert] = "Please correct your email address"
  end
end
