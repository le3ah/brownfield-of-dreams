require 'rails_helper'

describe 'User Friendships' do
  describe 'as a logged in user' do
    it 'shows a button to add as a friend' do
      user_1 = create(:user, github_token: ENV["GITHUB_TOKEN"])
      user_2 = create(:user, github_token: "imatoken", github_name: "mgoodhart5")
      user_3 = create(:user, github_token: "tokentoken", github_name: "danbriechle")
      stub_omniauth
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      facade_user = UserDashboardFacade.new(user_1)
      followers = facade_user.find_all_followers
      following = facade_user.find_all_following

      visit '/dashboard'
      
      within '.following-list' do
        within ".follow-2" do
          expect(page).to have_button("Add as Friend")
        end
      end
      within '.followers-list' do
        within ".follower-0" do
          expect(page).to have_button("Add as Friend")
        end
      end
    end

    it 'can add friends' do
      user_1 = create(:user, github_token: ENV["GITHUB_TOKEN"])
      user_2 = create(:user, github_token: "imatoken", github_name: "mgoodhart5")
      user_3 = create(:user, github_token: "tokentoken", github_name: "danbriechle")

      stub_omniauth
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      facade_user = UserDashboardFacade.new(user_1)
      followers = facade_user.find_all_followers
      following = facade_user.find_all_following

      visit '/dashboard'

      within '.following-list' do
        within ".follow-2" do
          expect(page).to have_button("Add as Friend")
          click_button "Add as Friend"
        end
      end
      expect(page).to have_content("Added your new Friend!")
      expect(current_path).to eq(dashboard_path)

      within '.followers-list' do
        within ".follower-0" do
          expect(page).to have_button("Add as Friend")
          click_button "Add as Friend"
        end
      end
      expect(page).to have_content("Added your new Friend!")
      expect(current_path).to eq(dashboard_path)
    end

    it 'shows a list of friends' do
      user_1 = create(:user, github_token: ENV["GITHUB_TOKEN"])
      user_2 = create(:user, github_token: "imatoken", github_name: "mgoodhart5")
      user_3 = create(:user, github_token: "tokentoken", github_name: "danbriechle")

      stub_omniauth
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      facade_user = UserDashboardFacade.new(user_1)
      followers = facade_user.find_all_followers
      following = facade_user.find_all_following

      visit '/dashboard'

      within '.following-list' do
        within ".follow-2" do
          click_button "Add as Friend"
        end
      end

      within '.friend-list' do
        expect(page).to have_content("Your Friends")
        expect(page).to have_content("mgoodhart")
      end
    end
  end
end
