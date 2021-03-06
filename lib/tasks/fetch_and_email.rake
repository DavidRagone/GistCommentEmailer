namespace :task do
  desc "Create new gist records"
  task fetch: :environment do
    users = GithubUser.actives
    users.each do |user|
      github = Github.new(oauth_token: user.oauth_token)
      new_gists = GistFetcher.new(github).get
      user.gists.create_from_hashie_mash(new_gists)
    end
  end

  desc "Email records to users"
  task email: :environment do
    users = GithubUser.actives.have_new_comments
    users.each do |user|
      gists = user.gists.with_new_comments
      GistMailer.new_comments(user, gists).deliver
    end
  end

  desc "Reset records"
  task reset: :environment do
    GithubUser.update_all has_new_comments: false
    Gist.update_all new_comments: 0
  end

  task fetch_and_email: [:reset, :fetch, :email] do
  end
end
