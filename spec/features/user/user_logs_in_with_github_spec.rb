require 'rails_helper'

describe 'dashboard' do
  describe 'as a user who has not logged into github' do
    it "can login to github", :vcr do
      stub_omniauth

      user_1 = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/dashboard'
      expect(page.status_code).to eq(200)
      expect(page).to_not have_content('Github')
      expect(page).to_not have_content('Following')

      click_button "Connect to Github"

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content('Github')
      expect(page).to have_content('Following')
    end
  end
end
