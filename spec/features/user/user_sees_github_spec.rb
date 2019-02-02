require 'rails_helper'

describe 'dashboard' do
  context 'as a logged in user with a token' do
    it 'sees Github list of 5 repositories linking to repo', :vcr do

      user = create(:user, oauth_token: ENV["GITHUB_TOKEN"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content("Github")

      within('.github-list') do
        expect(page).to have_link("2win_playlist")
        expect(page).to have_css(".repository", count: 5)
      end
    end
    context 'as a logged in user without a token' do
      it "does not see links to github repos", :vcr do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(page).to_not have_content("Github")
        expect(page).to_not have_css(".repository")
      end
    end
  end
end
