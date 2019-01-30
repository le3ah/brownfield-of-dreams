require 'rails_helper'

describe 'dashboard' do
  context 'as a logged in user with a token' do
    it 'sees Github list of 5 repositories linking to repo', :vcr do
      user = create(:user, token: "cheezytoken")
      token = user.token

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content("Github")

      within('.github') do
        expect(page).to have_link("2win_playlist")
        expect(page).to have_css(".repository", count: 5)
      end
    end
    it "sees repos belonging to appropriate user ", :vcr do
      user_1 = create(:user, token: "cheezytoken")
      user_2 = create(:user, token: "notcheezytoken")
      token_1 = user_1.token
      token_2 = user_2.token

      visit '/'

      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user_1.email
      fill_in 'session[password]', with: user_1.password

      click_on 'Log In'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Github")

      user_1_repos = Repo.find_all_repos(token_1)
      user_2_repos = Repo.find_all_repos(token_2)
      within('.github') do
        user_2_repos = Repo.find_all_repos(token_2)
        expect(page).to have_link("#{user_1_repos.first.name}")
        # expect(page).to_not have_link("#{user_2_repos.first.name}")
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