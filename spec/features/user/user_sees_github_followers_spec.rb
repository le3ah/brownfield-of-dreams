require 'rails_helper'

describe 'dashboard' do
  context 'as a logged in user with a token' do
    it "sees a Followers section within the Github section", :vcr do
      user_1 = create(:user, token: "cheezytoken")
      token_1 = user_1.token
      user_1_followers = Follower.find_all_followers(token_1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/dashboard'
      expect(page).to have_content('Github')
      expect(page).to have_content('Followers')
      within('.followers-list') do
        expect(page).to have_link(user_1_followers.first.login)
        expect(page).to have_link(user_1_followers.last.login)
        expect(page).to have_css(".follower")
      end
    end
  end

  context 'as a logged in user without a token' do
    it "does not see links to followers' githubs", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_content("Followers")
      expect(page).to_not have_css(".followers-list")
    end
  end
end
