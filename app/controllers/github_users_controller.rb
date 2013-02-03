class GithubUsersController < ApplicationController
  before_filter :redirect_unless_correct_user

  def edit
    @user = current_user
    @gists = current_user.gists
  end

  def update
    current_user.update_attributes(params[:github_user])
    sign_in current_user
    render 'update', formats: :js
  end

  def destroy
  end

private
  def redirect_unless_correct_user
    redirect_to root_path unless signed_in? && current_user == GithubUser
      .find_by_id(params[:id])
  end
end
