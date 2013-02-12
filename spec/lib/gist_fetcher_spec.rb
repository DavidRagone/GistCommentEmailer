require 'spec_helper'

describe GistFetcher do
  describe '#get' do
    let(:get) { GistFetcher.new(github).get }
    let(:github) { Github.new(oauth_token: ENV['MY_OAUTH_TOKEN']) }
    before(:all) do
      @new_gist = github.gists.create('description' => 'test gist',
                                     'public' => false,
                                     'files' => { 
                                       'file1.txt' => {
                                         'content' => 'String file contents'
                                       }
                                     }
                                    )
    end

    after(:all) do
      github.gists.delete(@new_gist.id)
    end

    it 'returns an array of Hashie::Mash objects (gists)' do
      response = get
      response.should be_an_instance_of Array
      response.first.should be_an_instance_of Hashie::Mash
      response.each { |gist| gist.owner.id.should eq ENV['MY_GITHUB_ID'].to_i }
    end

    it 'stores the results in a new instance variable' do
      fetcher = GistFetcher.new(github)
      response = fetcher.get
      fetcher.gists.should eq response
    end
  end
end
