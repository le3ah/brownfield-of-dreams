require 'rails_helper'

describe 'visitor sees about page' do
  it "should see tutorials explanation" do
    visit about_path

    expect(page).to have_content("Turing Tutorials")
  end
end
