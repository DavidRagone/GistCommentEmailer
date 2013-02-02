class GithubUsersController < ApplicationController
  def edit
    @user = current_user
    @gists = []
  end

  def update
  end

  def destroy
  end
end
