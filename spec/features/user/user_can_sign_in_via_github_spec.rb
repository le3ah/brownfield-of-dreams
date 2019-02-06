require 'rails_helper'

describe 'login' do
  it "can sign in via Github", :vcr do
    user_1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    stub_omniauth

    visit '/dashboard'

    expect(page).to_not have_content('Followers')
    expect(page).to_not have_content('Github')
    expect(page).to have_content('You have no bookmarked sections')

    click_button 'Connect to Github'

    expect(page.status_code).to eq(200)
    expect(page).to have_content('Github')
    expect(page).to have_content('Followers')
  end
end
