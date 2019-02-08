require 'rails_helper'

describe 'User' do
  it "can see classroom content when logged in", :vcr do
    user = create(:user, github_token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    tutorial = Tutorial.create!(title: "How To", classroom: true)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial, position: 1)

    visit tutorial_path(tutorial)

    expect(page).to have_content(video.title)
  end
  it "cannot see classroom content when not logged in", :vcr do
    user = create(:user, github_token: nil)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    tutorial = Tutorial.create!(title: "How To", classroom: true)
    tutorial_1 = Tutorial.create!(title: "How Not To", classroom: false)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial, position: 1)
    video_1 = create(:video, title: "The Fish Ears Technique", tutorial: tutorial_1, position: 1)

    visit tutorial_path(tutorial)
    expect(page).to_not have_content(video.title)

    visit tutorial_path(tutorial_1)
    expect(page).to have_content(video_1.title)
  end
end
