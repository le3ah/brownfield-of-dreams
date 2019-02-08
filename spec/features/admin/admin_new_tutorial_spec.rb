require 'rails_helper'

describe "As an Admin" do
  describe 'when they visit the dashboard' do
    it "can add a new tutorial"  do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_link "New Tutorial"

      expect(current_path).to eq(new_admin_tutorial_path)
      fill_in "tutorial[title]", with: "How to make coffee"
      fill_in "tutorial[description]", with: "Do this"
      fill_in "tutorial[thumbnail]", with: "picture"

      click_on "Save"
      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Admin Dashboard")
    end

  end
end
