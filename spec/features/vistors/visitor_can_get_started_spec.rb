require 'rails_helper'

describe 'visitor sees get started info' do
  it "should have options to return to root path" do

    visit get_started_path

    within '.browse' do
      expect(page).to have_content("Browse tutorials")
      click_link "homepage"
    end
    expect(current_path).to eq(root_path)

    visit get_started_path
    within '.filter' do
      click_link "homepage"
    end
    expect(current_path).to eq(root_path)
  end
  it "should be able to log in" do
    visit get_started_path

    within '.register' do
      click_link "Sign in"
    end
    expect(current_path).to eq(login_path)
  end
end
