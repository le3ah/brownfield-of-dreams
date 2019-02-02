require 'rails_helper'

describe 'dashboard' do
  context 'as a logged in user with valid token' do
    it 'user sees own repos', :vcr do
      leah = create(:user, oauth_token: ENV["GITHUB_TOKEN"])
      ali = create(:user, oauth_token: ENV["GITHUB_TOKEN_OTHER"])
      token_1 = leah.oauth_token
      token_2 = ali.oauth_token
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(leah)

      visit '/dashboard'

      expect(page).to have_content("Github")

      user_leah_repos = Repo.find_all_repos(token_1)
      user_ali_repos = Repo.find_all_repos(token_2)

      within('.github-list') do
        expect(page).to have_link("#{user_leah_repos.first.name}")
        expect(page).to_not have_link("#{user_ali_repos.last.name}")
      end
    end
  end
end
