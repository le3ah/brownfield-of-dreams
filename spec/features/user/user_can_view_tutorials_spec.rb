require 'rails_helper'

describe 'As a valid user' do
  describe 'when the visit the tutorials show page' do
    it 'shows videos' do
      tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
      video_1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1, position: 1)
      video_2 = create(:video, title: "The Wanda Technique", tutorial: tutorial_1, position: 2)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit tutorial_path(tutorial_1)

      expect(page).to have_link(video_1.title)
      expect(page).to have_link(video_2.title)
    end
  end
  describe 'when the visit the tutorials index page' do
    it 'shows videos' do
      tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
      video_1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1, position: 1)
      video_2 = create(:video, title: "The Wanda Technique", tutorial: tutorial_1, position: 2)
      tutorial_2 = create(:tutorial, title: "How to Tie Your Shoes")
      video_3 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_2, position: 1)
      video_4 = create(:video, title: "The Wanda Technique", tutorial: tutorial_2, position: 2)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit tutorials_path

      expect(page).to have_link(tutorial_1.title)
      expect(page).to have_content(tutorial_1.description)
      expect(page).to have_link(tutorial_2.title)
      expect(page).to have_content(tutorial_2.description)
    end
  end
end
