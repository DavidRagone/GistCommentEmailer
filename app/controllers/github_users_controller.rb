class GithubUsersController < ApplicationController
  respond_to :html, :js, :json

  def edit
    @user = current_user
    @gists = current_user.gists
  end

  def update
    current_user.update_attributes(params[:github_user])
    sign_in current_user
    respond_with :js
  end

  def destroy
  end
end
