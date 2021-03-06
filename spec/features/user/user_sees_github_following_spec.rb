require 'rails_helper'

describe 'dashboard' do
  context 'as a logged in user with a token' do
    it "sees a Following section within the Github section", :vcr do
      user_1 = create(:user, github_token: ENV["GITHUB_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      facade_user = UserDashboardFacade.new(user_1)
      following = facade_user.find_all_following

      visit '/dashboard'
      expect(page).to have_content('Github')
      expect(page).to have_content('Following')
      within('.following-list') do
        expect(page).to have_link(following.first.login)
        expect(page).to have_link(following.last.login)
        expect(page).to have_css(".following")
      end
    end
  end

  context 'as a logged in user without a token' do
    it "does not see links to following' githubs", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_content("Following")
      expect(page).to_not have_css(".following-list")
    end
  end
end
