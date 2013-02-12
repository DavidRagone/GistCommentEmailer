  desc "Create new gist records" do
    task fetch: :environment do
      users = GithubUser.actives
      users.each do |user|
        github = Github.new(oauth_token: user.oauth_token)
        new_gists = GistFetcher.new(github).get
        user.gists.create_from_hashie_mash(new_gists)
      end
    end

    Rake::Task[:email].invoke
  end

  desc "Email records to users" do
    task email: :environment do
      users = GithubUsers.actives.have_new_comments
      users.each do |user|
        gists = user.gists.with_new_comments
        GistMailer.new_comments(user, gists)
      end
    end
  end
