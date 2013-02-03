require 'spec_helper'

describe GithubUsersController do
  pending "making the stupid sign_in thing actually work" do
  describe '#edit' do
    let!(:make_request) { xhr :get, :edit, id: user.id }
    let(:user) { FactoryGirl.create :github_user }

    it 'redirects guests' do
      expect { make_request }.to redirect_to root_path
    end

    context 'signed in user' do
      before { sign_in user }

      it "assigns @user && @gists" do
        make_request
        expect(assigns(:user)).to eq user
        expect(assigns(:gists)).to eq user.gists
      end

      it "renders user's own page" do
        expect { make_request }.not_to redirect_to root_path
      end

      it "redirects for other users' pages" do
        expect { get :edit, id: 5 }.to redirect_to edit_github_user_path(user)
      end
    end
  end
  end
end
