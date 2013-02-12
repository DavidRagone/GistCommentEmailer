class GistFetcher
#@github = Github.new(oauth_token: @user.oauth_token)
#@github.gists.list since: 1.day.ago

  attr_accessor :gists

  def initialize(github)
    @github = github
  end

  def get
    @gists = @github.gists.list since: 1.day.ago
  end
end
